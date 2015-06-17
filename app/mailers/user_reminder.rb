class UserReminder < ActionMailer::Base
  default from: "support@dhoomdhamaka.com", :sent_on => Time.now.to_s

  def send_reminder_email(event)
    @event = event
    @user = event.user
    mail(:to => event.user.email, :subject =>'Event reminder')
  end

  def send_reminder_message(event)
    @event = event
    @mobile = event.user.mobile

    event_message = "This is your friendly reminder that your #{@event.program} event is on #{@event.date.strftime("%b %d %Y")}. So, Please be prepare for the function."
    response = Unirest.get "https://site2sms.p.mashape.com/index.php?msg=#{event_message.to_s}&phone=#{@mobile}&pwd=262360&uid=9650621543",
                           headers:{
                               "X-Mashape-Key" => "lHwv3VsIn8mshMui2N6NbDzRJMJOp1NISLxjsnAh90sLzPLxLq",
                               "Accept" => "application/json"
                           }
  end

  def send_reminder_email_for_not_logged_in(user)
    @user = user
    mail(:to => user.email, :subject =>'Reminder email for not logged in from last 5 days')
  end

end