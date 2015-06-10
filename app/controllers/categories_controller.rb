class CategoriesController < ApplicationController
  before_action :authenticate_user!, :except=>[:show]
  layout 'plain', :only=>[:show]
  def index
    @categories = current_user.categories
  end

  def show
    @category = Category.friendly.find(params[:id])
  end

  def new
    @category = Category.new
  end

  def create
    if params[:category].present?
      @category = Category.new(category_params.merge(user_id: current_user.id))
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

    if @category.update(category_params.merge(user_id: current_user.id))
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

  def category_params
    params.require(:category).permit(:name, :category_type, :service_area, :email,:address,
                                     :mobile, :no_of_employees, :min_price, :max_price, :description, :latitude,:longitude)
  end

end