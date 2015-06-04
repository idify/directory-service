class CategoriesController < ApplicationController
  before_action :authenticate_user!

  def index
    @categories = Category.all
  end

  def show
    @category = Category.friendly.find(params[:id])
  end

  def new
    @category = Category.new
  end

  def create
    if params[:category].present?
      @category = Category.new(category_params)
    end

    if @category.save
      redirect_to categories_path
    else
      render 'new'
    end
  end

  def edit
    @category = Category.find(params[:id])
  end

  def update
    @category = Category.find(params[:id])

    if @category.update_attributes(category_params)
      redirect_to categories_path
    else
      render 'edit'
    end
  end

  def destroy
    @category = Category.find(params[:id])

    if @category.destroy
      redirect_to categories_path
    else
      render 'index'
    end
  end

  def category_params
    params.require(:category).permit(:name, :category_type, :service_area, :email,:address,
                                     :mobile, :no_of_employees, :min_price, :max_price, :description, :latitude,:longitude)
  end

end