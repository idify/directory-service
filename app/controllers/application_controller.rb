class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  include SimpleCaptcha::ControllerHelpers

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:email, :password, :password_confirmation, :mobile) }
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:email, :password, :password_confirmation, :current_password, :first_name, :last_name, :mobile)}
  end

  rescue_from ActiveRecord::RecordNotFound do
    flash[:warning] = 'Resource not found.'
    redirect_back_or root_path
  end

  def redirect_back_or(path)
    redirect_to request.referer || path
  end

  def check_if_mobile_verified
    if current_user && current_user.provider == 'twitter' && !current_user.is_verified? && !current_user.is_twitter_email_verified?
      redirect_to :get_twitter_email
    elsif current_user && !current_user.is_verified?
      redirect_to :verify_mobile
    end
  end
end
