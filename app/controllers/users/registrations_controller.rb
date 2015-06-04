class Users::RegistrationsController < Devise::RegistrationsController

  private

  def sign_up_params
    params.require(:user).permit(:email, :mobile, :password, :password_confirmation, :role, :verification_code, :is_verified)
  end

  def account_update_params
    params.require(:user).permit(:first_name, :last_name, :email, :mobile, :password, :password_confirmation, :current_password)
  end
end
