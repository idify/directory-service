class InvitationMailer < ActionMailer::Base
  default from: "support@dhoomdhamaka.com", :sent_on => Time.now.to_s

  def invitation_email(contact,current_user)
    @contact = contact
    @user = current_user
    mail(:to => contact.email, :subject =>'Invitation from Directory Service')
  end

end