class SubsitesController < ApplicationController

  before_action :authenticate_user!, except: [:show, :subsite_contact_us]

  def new
    @subsite = Subsite.new
  end

  def create

    if params[:subsite].present?
      @subsite= Subsite.new(template_type: params[:subsite][:template_type],
                            domain_name: params[:subsite][:domain_name],
                            contact_email: params[:subsite][:contact_email],
                            contact_address: params[:subsite][:contact_address],
                            invitees: params[:subsite][:invitees].join(','),
                        user_id: current_user.id)
      if @subsite.save
        redirect_to root_path, notice: 'Your website is successfully created.'
      else
        render 'new'
      end
    end

  end

  def edit
    @subsite = Subsite.find(params[:id])
  end

  def update
    @subsite = Subsite.find(params[:id])

    if params[:subsite].present?
      if @subsite.update_attributes(template_type: params[:subsite][:template_type],
                            domain_name: params[:subsite][:domain_name],
                            contact_email: params[:subsite][:contact_email],
                            contact_address: params[:subsite][:contact_address],
                            invitees: params[:subsite][:invitees].join(','),
                            user_id: current_user.id)
        redirect_to root_path, notice: 'Your website information is successfully updated.'
      else
        render 'edit'
      end
    end

  end

  def show
    @subsite= Subsite.find_by_domain_name(request.subdomain)
    @subsite_contact = SubsiteContact.new
    if @subsite.present?
      @ceremonies = @subsite.user.ceremonies.where('public=?', true).order(:date)
      render layout: 'vintage'
    end
  end

  def subsite_contact_us
    @subsite= Subsite.find_by_domain_name(request.subdomain)

    if params[:subsite_contact].present? && params[:subsite_contact][:name].present? &&
        params[:subsite_contact][:email].present? && params[:subsite_contact][:subject].present?

      @subsite_contact = SubsiteContact.new(name: params[:subsite_contact][:name],email: params[:subsite_contact][:email],
                         subject: params[:subsite_contact][:subject],message: params[:subsite_contact][:message])

      if @subsite_contact.save
        SubsiteContactMailer.mail_to_subsite_owner(@subsite_contact,@subsite.user.email).deliver
        redirect_to :back, :notice => 'Your contact details has been sent successfully.'
      end
    else
      redirect_to :back, :alert=> 'Please fill the below form to contact us.'
    end
  end

end