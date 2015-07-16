class WishlistsController < ApplicationController

  def index
    if current_user.vendor? && current_user.categories.present?
      @category_types = current_user.categories.map(&:category_type)
      @wishlists = []

      @category_types.each do |category_type|
        @wishlists << Wishlist.where("category=?",category_type)
      end
    else
      redirect_to root_path
    end
  end

  def new
    if current_user.customer?
      @wishlist = Wishlist.new
    else
      redirect_to root_path
    end
  end

  def create
    if params[:wishlist].present?
      @wishlist =  Wishlist.new(:name=> params[:wishlist][:name], :category=>params[:wishlist][:category], :mobile_number=>params[:wishlist][:mobile_number],
                      :email=>params[:wishlist][:email],:program_date=> Time.strptime(params[:wishlist][:program_date], "%m/%d/%Y").strftime('%Y-%m-%d'),
                      :city=>params[:wishlist][:city], :wish_list=>params[:wishlist][:wish_list], user_id: current_user.id)

      if @wishlist.save
        redirect_to root_path, notice: 'You have successfully shared your wishlist with the vendor.'
      else
        render 'new'
      end
    end
  end

end