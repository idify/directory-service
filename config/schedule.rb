set :output, "log/cron_log.log"
set :environment, "development"

every 1.day do
  rake "reminder_email_task:send"
  rake "reminder_message_task:send"
  rake "reminder_if_not_logs_in_for_days:send"
  rake "retrieve_emails:send"
end