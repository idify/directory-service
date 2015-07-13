namespace :reminder_if_not_logs_in_for_days do
  desc "Rake task to send reminder email to the user for not logging for 5 days"

  task :send => :environment do
    users_list = User.get_users_not_logged_in_from_last_five_days

    if users_list.present?
      users_list.each do |user|
        begin
          UserReminder.send_reminder_email_for_not_logged_in(user).deliver
          puts "#{Time.now} - Success! email reminder for user: #{user.email} for not logged in from last five days."
        rescue Exception => e
          puts e.message
        end
      end
    end

  end
end