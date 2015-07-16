class GalleriesController < ApplicationController

  before_action :authenticate_user!

  def new;end

  def create
    if params[:gallery].present? && params[:gallery][:type].present?
      gallery_params = params[:gallery]

      if gallery_params[:attachment].present?
        if gallery_params[:type]=='Image'
          gallery_params[:attachment].each do |attachment|
            Image.create( user_id: current_user.id,photo: attachment)
          end
        elsif gallery_params[:type]=='Video'
          gallery_params[:attachment].each do |attachment|
            Video.create( user_id: current_user.id,video: attachment)
          end
        end
      end

      if params[:gallery][:url].present?
        @video_url = VideoUrl.create(user_id: current_user.id, :url=>params[:gallery][:url])
      end
    end

    redirect_to galleries_path
  end

  def delete_photo
    @image = Image.find(params[:id])

    if @image.destroy
      redirect_to galleries_path, notice: "Picture has been deleted."
    end
  end

  def delete_video
    @video = Video.find(params[:id])

    if @video.destroy
      redirect_to galleries_path, notice: "Video has been deleted."
    end
  end

  def delete_video_url
    @video_url = VideoUrl.find(params[:id])

    if @video_url.destroy
      redirect_to galleries_path, notice: "Video has been deleted."
    end
  end

  def index;end

end
