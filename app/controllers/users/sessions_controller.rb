class Users::SessionsController < Devise::SessionsController

  layout 'plain'

  before_action :authenticate_user!, :only=>[:verify_mobile]

  before_action :check_if_mobile_verified, :only=>[:new, :create]

  def destroy
    super
  end

  def verify_mobile
    unless current_user.present?
      redirect_to root_path
    end
  end

  def sms_verify
    # These code snippets use an open-source library. http://unirest.io/ruby
    if params[:number].present?
      r=Random.new
      random_value=r.rand(1000...9999)
      verify_text = 'Your mobile number verification code for Directory service is:'
      response = Unirest.get "https://site2sms.p.mashape.com/index.php?msg=#{verify_text.to_s+random_value.to_s}&phone=#{params[:number]}&pwd=262360&uid=9650621543",
                             headers:{
                                 "X-Mashape-Key" => "lHwv3VsIn8mshMui2N6NbDzRJMJOp1NISLxjsnAh90sLzPLxLq",
                                 "Accept" => "application/json"
                             }
      if current_user.update_attributes(:verification_code=>random_value)
        render :text=> true
      end
    end
  end

  def check_code
    if (params[:number]).to_i==current_user.verification_code.to_i
      current_user.update_attributes(:is_verified=>true)
      render :text=> true
    else
      render :text=> false
    end
  end

end