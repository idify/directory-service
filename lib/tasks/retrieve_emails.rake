namespace :retrieve_emails do
  desc "Rake task to retrieve emails replies"

  task :send => :environment do
    Mail.defaults do
      retriever_method :pop3, :address    => "pop.gmail.com",
                       :port       => 995,
                       :user_name  => 'test1@idifysolutions.com',
                       :password   => 'd1lsedosti',
                       :enable_ssl => true
    end

    emails = Mail.first
    # # all_emails.each do |email|
    # #   puts email.subject
    # # end
    puts emails.inspect

    # emails = Mail.find(:what => :last, :count => 10, :order => :asc)
    # puts emails

  end
end