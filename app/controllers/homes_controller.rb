class HomesController < ApplicationController
  before_action :authenticate_user!

  def dashboard
  end

  def search
    if params[:city_name].present? or params[:category_type].present?
      @serached_results = Category.where("category_type=? or service_area=?", params[:category_type], Location.find_by_name(params[:city_name]).id)
    else
      @serached_results = Category.all
    end
    render 'dashboard'
  end
end
