namespace :retrieve_emails do
  desc "Rake task to retrieve emails replies"

  task :send => :environment do
    Mailman.config.ignore_stdin = true
    Mailman.config.poll_interval = 300  # change this number as per your needs. Default is 60 seconds

    Mailman.config.pop3 = {
        server: 'pop.gmail.com',
        port: 995,
        ssl: true,
        username: "test1@idifysolutions.com",
        password: "d1lsedosti"
    }

    Mailman::Application.run do
      default do
        begin
          if message.subject.present? && message.subject.to_s.include?('Directory-service')
            MessageReply.save_email_replies(message)
          end
        rescue Exception => e
          Mailman.logger.error "Exception occurred while receiving message:n#{message}"
          Mailman.logger.error [e, *e.backtrace].join("n")
        end
      end
    end
  end
end