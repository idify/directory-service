class ProfilePicsController < ApplicationController

  before_action :authenticate_user!

  def new
    @profile_pic = ProfilePic.new
  end

  def create
    if params[:profile_pic].present?
      profile_pic_params = params[:profile_pic]

      if current_user.profile_pic.present?
        current_user.profile_pic.update_attributes( user_id: current_user.id,logo: profile_pic_params[:logo], header_image: profile_pic_params[:header_image])
      else
        ProfilePic.create(user_id: current_user.id,logo: profile_pic_params[:logo], header_image: profile_pic_params[:header_image])
      end
    end

    redirect_to profile_pics_path, :notice => 'You have added Business Images successfully.'
  end

  def index
    @profile_pic = current_user.profile_pic
  end
end
