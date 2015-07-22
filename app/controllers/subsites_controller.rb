class SubsitesController < ApplicationController

  before_action :authenticate_user!

  def new
    @subsite = Subsite.new
  end

  def create

    if params[:subsite].present?
      @subsite= Subsite.new(template_type: params[:subsite][:template_type],
                            domain_name: params[:subsite][:domain_name],
                            contact_email: params[:subsite][:contact_email],
                            invitees: params[:invitees].join(','),
                        user_id: current_user.id)
      if @subsite.save
        redirect_to root_path, notice: 'Your website is successfully created.'
      end
    end

  end

  def show
    @subsite= Subsite.find_by_domain_name(request.subdomain)
    @ceremonies = current_user.ceremonies.order(:date)
    render layout: 'vintage'
  end

end