namespace :reminder_email_task do
  desc "Rake task to send reminder email to the user prior to the events"

  task :send => :environment do
    one_day_prior_user_all_events= Ceremony.get_one_day_prior_events_list_for_sending_reminder_email

    three_day_prior_user_all_events= Ceremony.get_three_day_prior_events_list_for_sending_reminder_email

    seven_day_prior_user_all_events= Ceremony.get_seven_day_prior_events_list_for_sending_reminder_email

    if one_day_prior_user_all_events.present?
      one_day_prior_user_all_events.each do |event|
        if Date.today+ 1.day == event.date
          begin
            UserReminder.send_reminder_email(event).deliver
          rescue Exception => e
            puts e.message
          end
        end

        puts "#{Time.now} - Success! 1 day prior email reminder for user: #{event.user.email} for event: #{event.program}."
      end
    end

    if three_day_prior_user_all_events.present?
      three_day_prior_user_all_events.each do |event|
        if Date.today+ 3.day == event.date
          begin
            UserReminder.send_reminder_email(event).deliver
          rescue Exception => e
            puts e.message
          end
        end

        puts "#{Time.now} - Success! 3 day prior email reminder for user: #{event.user.email} for event: #{event.program}."
      end
    end

    if seven_day_prior_user_all_events.present?
      seven_day_prior_user_all_events.each do |event|
        if Date.today+ 7.day == event.date
          begin
            UserReminder.send_reminder_email(event).deliver
          rescue Exception => e
            puts e.message
          end
        end

        puts "#{Time.now} - Success! 7 day prior email reminder for user: #{event.user.email} for event: #{event.program}."
      end
    end
  end
end