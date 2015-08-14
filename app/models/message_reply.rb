class MessageReply < ActiveRecord::Base

  def self.save_email_replies(message)
    message_body = EmailReplyParser.parse_reply(message.text_part.body.to_s)

    conversation = Mailboxer::Conversation.find_by_subject(message.subject.to_s.gsub('Re: Mailboxer new message: ', ''))

    mailboxer_notification = Mailboxer::Notification.create(type: 'Mailboxer::Message',
                                                            sender_id: User.find_by_email(message.from.first).id,
                                                            sender_type: 'User',
                                                            conversation_id: conversation.present? ? conversation.id : nil,
                                                            body: message_body.present? ? message_body : '',
                                                            subject: message.subject)

    mailboxer_notification_from_sender = Mailboxer::Notification.find_by_subject(message.subject.to_s.gsub('Re: Mailboxer new message: ', ''))

    receiver_id = mailboxer_notification_from_sender.present? ? mailboxer_notification_from_sender.sender_id : nil

    Mailboxer::Receipt.create(mailbox_type: 'inbox',
                              receiver_id: receiver_id ,
                              receiver_type: 'User',
                              notification_id: mailboxer_notification.present? ? mailboxer_notification.id : '')
  end
end
