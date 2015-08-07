Mailboxer.setup do |config|

  #Configures if you application uses or not email sending for Notifications and Messages
  config.uses_emails = true

  #Configures the default from for emails sent for Messages and Notifications
  config.default_from = "test1@idifysolutions.com"

  #Configures the methods needed by mailboxer
  config.email_method = :mailboxer_email
  config.name_method = :name

  #Configures if you use or not a search engine and which one you are using
  #Supported engines: [:solr,:sphinx]
  config.search_enabled = false
  config.search_engine = :solr

  #Configures maximum length of the message subject and body
  config.subject_max_length = 255
  config.body_max_length = 32000
end

Mailboxer::Message.class_eval do
  has_attached_file :document
  validates_attachment_content_type :document, :content_type => ['application/pdf', 'application/msword','application/vnd.ms-excel','text/plain', "image/jpeg", "image/gif", "image/png"]
  validates_attachment :document
end
