class GuestsController < ApplicationController
  before_action :authenticate_user!

  def index
    @guests = Guest.all
  end

  def show
    @guest = Guest.find(params[:id])
  end

  def new
    @guest = Guest.new
  end

  def create
    if params[:guests].present?

      params[:guests].each do |guest_param|
        @guest= Guest.new(name: guest_param[:name], email: guest_param[:email],
                          mobile: guest_param[:mobile], city: guest_param[:city],
                          user_id: current_user.id)
        @guest.save
      end
    end

    if current_user.guests.present?
      redirect_to guests_path
    else
      render 'new'
    end
  end

  def edit
    @guest = Guest.find(params[:id])
  end

  def update
    @guest = Guest.find(params[:id])

    guest_param = params[:guests].first

    if @guest.update_attributes(name: guest_param[:name], email: guest_param[:email],
                        mobile: guest_param[:mobile], city: guest_param[:city])
      redirect_to guests_path
    else
      render 'edit'
    end
  end

  def destroy
    @guest = Guest.find(params[:id])

    if @guest.destroy
      redirect_to guests_path
    else
      render 'index'
    end
  end

  def guest_params
    params.require(:guest).permit(:name, :email, :mobile, :city)
  end
end
