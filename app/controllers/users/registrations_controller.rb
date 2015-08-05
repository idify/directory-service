class Users::RegistrationsController < Devise::RegistrationsController

  layout 'plain', except:['edit', 'update']

  def check_email
    @user = User.find_by_email(params[:user][:email])

    respond_to do |format|
      format.json { render :json => !@user }
    end
  end

  def edit

  end

  def update
    super

    if params[:user][:email].present? && current_user.email != params[:user][:email]
      @user = User.find_by_email(params[:user][:email])

      if @user.present?
        @user.confirmed_at = nil
        @user.send_confirmation_instructions
      end
    end

    if params[:user][:mobile].present? && current_user.mobile.present? && current_user.mobile != params[:user][:mobile]
      @user = User.find_by_email(params[:user][:email])

      if @user.present?
        @user.is_verified = false
        @user.verification_code = nil
        @user.save
      end
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
