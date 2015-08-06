class HomesController < ApplicationController
  before_action :authenticate_user!, :only=>[:dashboard]

  layout :set_layout

  def set_layout
    if current_user.blank? && params[:action] =='search_results'
      'plain'
    elsif current_user.present? && params[:action] =='search_results'
      'application'
    end
  end

  def dashboard;end

  def index
    if current_user.present?
      redirect_to root_path
    end
  end

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
