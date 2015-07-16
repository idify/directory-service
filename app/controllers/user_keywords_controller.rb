class UserKeywordsController < ApplicationController

  before_action :authenticate_user!

  def index
    @user_keywords = current_user.user_keywords
  end

  def new
    @user_keywords = current_user.user_keywords
    @user_keyword = UserKeyword.new
  end

  def create
    if params[:user_keywords].present?
      params[:user_keywords].each do |user_keyword|
        UserKeyword.create(user_id: current_user.id,keyword: user_keyword[:keyword])
      end
    end

    if current_user.user_keywords.present?
      redirect_to new_user_keyword_path, :notice => 'You have added Keywords successfully.'
    end
  end

end
