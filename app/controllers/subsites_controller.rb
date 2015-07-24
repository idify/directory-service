class SubsitesController < ApplicationController

  before_action :authenticate_user!, except: [:show]

  def new
    @subsite = Subsite.new
  end

  def create

    if params[:subsite].present?
      @subsite= Subsite.new(template_type: params[:subsite][:template_type],
                            domain_name: params[:subsite][:domain_name],
                            contact_email: params[:subsite][:contact_email],
                            invitees: params[:subsite][:invitees].join(','),
                        user_id: current_user.id)
      if @subsite.save
        redirect_to root_path, notice: 'Your website is successfully created.'
      else
        render 'new'
      end
    end

  end

  def edit
    @subsite = Subsite.find(params[:id])
  end

  def update
    @subsite = Subsite.find(params[:id])

    if params[:subsite].present?
      if @subsite.update_attributes(template_type: params[:subsite][:template_type],
                            domain_name: params[:subsite][:domain_name],
                            contact_email: params[:subsite][:contact_email],
                            invitees: params[:subsite][:invitees].join(','),
                            user_id: current_user.id)
        redirect_to root_path, notice: 'Your website information is successfully updated.'
      else
        render 'edit'
      end
    end

  end

  def show
    logger.info("**********************subdomain is:**********************")
    logger.debug(request.subdomain)
    @subsite= Subsite.find_by_domain_name(request.subdomain)
    if @subsite.present?
      @ceremonies = @subsite.user.ceremonies.where('public=?', true).order(:date)
      render layout: 'vintage'
    end
  end

end