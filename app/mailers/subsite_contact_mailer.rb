class SubsiteContactMailer < ActionMailer::Base
  default from: "support@dhoomdhamaka.com", :sent_on => Time.now.to_s

  def mail_to_subsite_owner(subsite_contact,subsite_owner_email)
    @subsite_contact = subsite_contact
    @subsite_owner_email = subsite_owner_email
    mail(:to => @subsite_owner_email, :subject =>@subsite_contact.subject)
  end

end