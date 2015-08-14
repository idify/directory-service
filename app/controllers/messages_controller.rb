class MessagesController < ApplicationController

  before_action :authenticate_user!

  def new
    @chosen_recipient = User.find_by(id: params[:to].to_i) if params[:to]
  end

  def create
    recipients = User.where(id: params['recipients'])
    attachment_params = params[:attachment].present? ? params[:attachment] : nil
    conversation = current_user.send_message(recipients, params[:message][:body], "#{params[:message][:subject]}-Directory-service:#{Time.now}", attachment_params).conversation
    flash[:success] = "Message has been sent!"
    redirect_to conversation_path(conversation)
  end
end
