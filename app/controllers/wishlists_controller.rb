class WishlistsController < ApplicationController

  def index
    if current_user.categories.present?
      @wishlists = Wishlist.where("category=?",current_user.categories.first.category_type)
    end
  end

  def new
    @wishlist = Wishlist.new
  end

  def create
    if params[:wishlist].present?
      @wishlist =  Wishlist.new(:name=> params[:wishlist][:name], :category=>params[:wishlist][:category], :mobile_number=>params[:wishlist][:mobile_number],
                      :email=>params[:wishlist][:email],:program_date=> Time.strptime(params[:wishlist][:program_date], "%m/%d/%Y").strftime('%Y-%m-%d'),
                      :city_id=>params[:wishlist][:city_id], :wish_list=>params[:wishlist][:wish_list], user_id: current_user.id)

      if @wishlist.save
        redirect_to root_path, notice: 'You have successfully shared your wishlist with the vendor.'
      else
        render 'new'
      end
    end
  end

end