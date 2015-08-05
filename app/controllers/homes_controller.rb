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

  ##########################################################################
  # Showing 'Help/Disclaimers/Privacy Policy/Terms & Conditions' pages
  ##########################################################################
  def show
    if params[:page]
      info_page = params[:page]
      render :action => "#{info_page}"
    else
      redirect_to root_path
    end
  end
end
