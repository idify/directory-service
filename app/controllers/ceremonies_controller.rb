class CeremoniesController < ApplicationController

  before_action :authenticate_user!

  def index
    @ceremonies = Ceremony.all
  end

  def show
    @ceremony = Ceremony.find(params[:id])
  end

  def new
    @ceremony = Ceremony.new
  end

  def create
    if params[:ceremonies].present?

      params[:ceremonies].each do |ceremony_param|
        @ceremony= Ceremony.new(program: ceremony_param[:program], date: ceremony_param[:date],
                                time: ceremony_param[:time], venue: ceremony_param[:venue],
                                user_id: current_user.id)
        @ceremony.save
      end
    end

    if current_user.ceremonies.present?
      redirect_to ceremonies_path
    else
      render 'new'
    end
  end

  def edit
    @ceremony = Ceremony.find(params[:id])
  end

  def update
    @ceremony = Ceremony.find(params[:id])

    ceremony_param = params[:Ceremonies].first

    if @ceremony.update_attributes(name: ceremony_param[:name], email: ceremony_param[:email],
                                   mobile: ceremony_param[:mobile], city: ceremony_param[:city])
      redirect_to ceremonies_path
    else
      render 'edit'
    end
  end

  def destroy
    @ceremony = Ceremony.find(params[:id])

    if @ceremony.destroy
      redirect_to ceremonies_path
    else
      render 'index'
    end
  end

end
