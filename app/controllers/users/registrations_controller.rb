class Users::RegistrationsController < Devise::RegistrationsController

  layout 'plain', except:['edit', 'update']

  def check_email
    @user = User.find_by_email(params[:user][:email])

    respond_to do |format|
      format.json { render :json => !@user }
    end
  end

  private

  def sign_up_params
    params.require(:user).permit(:email, :mobile, :password, :password_confirmation, :role, :verification_code, :is_verified)
  end

  def account_update_params
    params.require(:user).permit(:first_name, :last_name, :email, :mobile, :password, :password_confirmation, :current_password)
  end
end
