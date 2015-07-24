class HomesController < ApplicationController
  before_action :authenticate_user!, :only=>[:dashboard]

  layout 'plain', :only=>[:search_results]

  def dashboard;end

  def index;end

  def search_page
    render layout: false
  end

  def search_results

  @search_params = params[:search_keyword]
    if @search_params.present?
      @searched_results = Category.where("keywords LIKE ?", "%#{params[:search_keyword]}%").paginate(:per_page=>10, :page=>params[:page])
    end
  end
end
