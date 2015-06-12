class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  before_action :authenticate_user!

  def facebook
    generic_callback('facebook')
  end

  def twitter
    generic_callback('twitter')
  end

  def generic_callback(provider)
    # You need to implement the method below in your model (e.g. app/models/user.rb)
    @user = User.from_omniauth(request.env["omniauth.auth"])

    if @user.provider == 'twitter'
      if @user.save(:validate => false)
        flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => "Twitter"
        sign_in_and_redirect @user, :event => :authentication #this will throw if @user is not activated
      else
        session["devise.#{provider}_data"] = request.env["omniauth.auth"]
        redirect_to new_user_registration_url
      end
    else
      if @user.persisted?
        flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => "Facebook"
        sign_in_and_redirect @user, :event => :authentication #this will throw if @user is not activated
        set_flash_message(:notice, :success, :kind => provider.capitalize) if is_navigational_format?
      else
        session["devise.#{provider}_data"] = request.env["omniauth.auth"]
        redirect_to new_user_registration_url
      end
    end
  end

  def google_oauth2
    @user = User.find_for_google_oauth2(request.env["omniauth.auth"], current_user)

    if @user.persisted?
      cookies.delete :google_oauth2_approval_prompt
      flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => "Google"
      sign_in_and_redirect @user, :event => :authentication
    else
      session["devise.google_data"] = request.env["omniauth.auth"]
      redirect_to new_user_registration_url
    end
  end


end
