require 'net/http'
require 'net/https'
require 'uri'
require 'rexml/document'

class ImportContactsController < ApplicationController

  before_action :authenticate_user!

  def authenticate
    @title = "Google Authetication"

    client_id = GOOGLE_CONFIG[:"#{Rails.env}"]['invite_client_id']
    googleauth_url = "#{root_url}import_contacts/authorise"
    google_root_url = "https://accounts.google.com/o/oauth2/auth?state=profile&redirect_uri="+googleauth_url+"&response_type=code&client_id="+client_id.to_s+"&approval_prompt=force&scope=https://www.google.com/m8/feeds/,https://www.googleapis.com/auth/contacts.readonly"
    redirect_to google_root_url
  end

  def authorise
    @title = "Google Authetication"
    token = params[:code]
    client_id = GOOGLE_CONFIG[:"#{Rails.env}"]['invite_client_id']
    client_secret = GOOGLE_CONFIG[:"#{Rails.env}"]['invite_client_secret']
    uri = URI('https://accounts.google.com/o/oauth2/token')
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    request = Net::HTTP::Post.new(uri.request_uri)

    googleauth_url = "#{root_url}import_contacts/authorise"
    request.set_form_data('code' => token, 'client_id' => client_id, 'client_secret' => client_secret, 'redirect_uri' => googleauth_url, 'grant_type' => 'authorization_code')
    request.content_type = 'application/x-www-form-urlencoded'
    response = http.request(request)
    response.code
    access_keys = ActiveSupport::JSON.decode(response.body)
    uri = URI.parse("https://www.google.com/m8/feeds/contacts/default/full?oauth_token="+access_keys['access_token'].to_s+"&max-results=50000&alt=json")

    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    request = Net::HTTP::Get.new(uri.request_uri)
    response = http.request(request)
    contacts = ActiveSupport::JSON.decode(response.body)
    contacts['feed']['entry'].each_with_index do |contact,index|
      unless contact.blank?
        name = contact['title']['$t']

        contact['gd$email'].to_a.each do |email|
          email_address = email['address']
          invite = Invite.where(:email => email_address, :invite_source => "Gmail", :user_id => current_user.id)
          unless invite.present? || (email_address == current_user.email)
            Invite.create(:full_name => name, :email => email_address, :invite_source => "Gmail", :user_id => current_user.id)
          end
        end
      end
    end
    redirect_to send_invite_import_contacts_path , :notice => "Invite or follow your Google contacts."
  end

  def send_invite
    @google_friends = Invite.where(:invite_source => "Gmail", :user_id => current_user.id)
  end

  def send_email_to_contacts
    respond_to do |format|
      invitees_emails_list = params[:ids].split(/,/)

      invitees_emails_list.each do |invitee|
        @contact = Invite.find(invitee)

        begin
          if @contact.present? && InvitationMailer.invitation_email(@contact,current_user).deliver
            format.html
            format.json  { render :json => 'Invitation Mail has been sent to your contacts.'}
          end
        rescue Exception => e
          puts e.message
          format.html
          format.json  { render :json => 'Invitation Mail has not been sent to your contacts.'}
        end
      end
    end
  end

  def facebook_callback
    @user = User.find_by_uid(params[:uid])
    flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => "Facebook"
    sign_in(:user, @user, { :bypass => true })
    redirect_to root_path
  end

end