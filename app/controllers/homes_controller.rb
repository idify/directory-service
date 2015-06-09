class HomesController < ApplicationController
  before_action :authenticate_user!, :only=>[:dashboard]

  layout 'plain', :only=>[:search_results]

  def dashboard;end

  def index;end

  def search_page
    render layout: false
  end

  def search_results
    # if params[:city_name].present? or params[:category_type].present?
    #   @serached_results = Category.where("category_type=? or service_area=?", params[:category_type], Location.find_by_name(params[:city_name]).
    # else
    #   @serached_results = Category.all
    # end
    # render 'dashboard'
    # end

  @search_params = params[:search_keyword]
    if @search_params.present?
      @searched_results = UserKeyword.where("keyword=? ", params[:search_keyword]).paginate(:per_page=>1, :page=>params[:page])
    end
  end
end
