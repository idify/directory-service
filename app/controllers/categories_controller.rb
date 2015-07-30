class CategoriesController < ApplicationController
  before_action :authenticate_user!, :except=>[:show, :sms_verify, :check_code, :save_references]
  before_action :check_if_vendor, :only=>[:new, :edit]

  layout :set_layout

  before_action :check_if_mobile_verified, :only=>[:index]

 def set_layout
   if current_user.blank? && params[:action] =='show'
     'plain'
   else
     'application'
   end
 end

  def index
    if current_user.vendor?
      @categories = current_user.categories
    else
      redirect_to ceremonies_path
    end
  end

  def show
    @category = Category.friendly.find(params[:id])
    @latitude = @category.latitude.present? ? @category.latitude : ''
    @longitude =@category.longitude.present? ? @category.longitude : ''
    @visitor = VisitorList.where("mobile_number = ? AND is_otp_confirmed = ?", session[:mobile_number],true).last
    @references = @category.references.present? ? @category.references : nil
    @reference = Reference.new
  end

  def new
    @category = Category.new
  end

  def create
    if params[:category].present?
      @category = Category.new(category_params.merge(user_id: current_user.id, keywords: params[:category][:keywords].join(',')))
    end

    if @category.save
      redirect_to categories_path, notice: 'Business info added sucessfully.'
    else
      render 'new'
    end
  end

  def edit
    @category = Category.friendly.find(params[:id])
  end

  def update
    @category = Category.friendly.find(params[:id])

    if @category.update(category_params.merge(user_id: current_user.id, keywords: params[:category][:keywords].join(',')))
      redirect_to categories_path, notice: 'Business info updated sucessfully.'
    else
      render 'edit'
    end
  end

  def destroy
    @category = Category.friendly.find(params[:id])

    if @category.destroy
      redirect_to categories_path, notice: 'Business info deleted.'
    else
      render 'index'
    end
  end

  def autocomplete_locations
    @terms = params[:term].split(', ')
    @locations = Location.order(:name).where("name ILIKE ?", "%#{@terms.last}%")
    respond_to do |format|
      format.html
      format.json {
        render json: @locations.map(&:name)
      }
    end
  end

  def sms_verify
    session[:mobile_number] = params[:mobile_number].present? ? params[:mobile_number] : nil
    # These code snippets use an open-source library. http://unirest.io/ruby
    if session[:mobile_number].present?
      r=Random.new
      random_value=r.rand(1000...9999)
      verify_text = 'Your mobile number verification code for Directory service is:'
      response = Unirest.get "https://site2sms.p.mashape.com/index.php?msg=#{verify_text.to_s+random_value.to_s}&phone=#{session[:mobile_number].to_i}&pwd=262360&uid=9650621543",
                             headers:{
                                 "X-Mashape-Key" => "lHwv3VsIn8mshMui2N6NbDzRJMJOp1NISLxjsnAh90sLzPLxLq",
                                 "Accept" => "application/json"
                             }
      logger.info("otp is :#{random_value.inspect}")

      @already_visitor = VisitorList.where("mobile_number=?", session[:mobile_number]).last

      if @already_visitor.blank?
        VisitorList.create(:mobile_number=> session[:mobile_number])
      end
      render :text=> true
    end
  end

  def check_code
    if params[:otp_code].present?
      @visitor = VisitorList.where("mobile_number=?", session[:mobile_number]).last
      if @visitor.present?
        @visitor.update_attribute("is_otp_confirmed", true)
        render :text=> true
      end
    else
      render :text=> false
    end
  end

  def check_if_vendor
    if current_user && current_user.customer?
      redirect_to '/'
    end
  end

  def save_references
    if params[:reference][:name].present? && params[:reference][:comment].present? && params[:reference][:category_id].present?

      @reference = Reference.new(name: params[:reference][:name], email: params[:reference][:email],
                                 comment: params[:reference][:comment], score: params[:score], category_id: params[:reference][:category_id])
      if @reference.save
        redirect_to :back
      end
    end
  end

  def category_params
    params.require(:category).permit(:name, :category_type, :service_area, :email,:address,
                                     :mobile, :no_of_employees, :min_price, :max_price, :description, :latitude,:longitude)
  end

end