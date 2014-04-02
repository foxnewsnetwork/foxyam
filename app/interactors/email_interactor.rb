class EmailInteractor

  attr_accessor :email, :inbox
  def initialize(email: email, inbox: inbox)
    @email = email
    @inbox = inbox
  end

  def store_email
    inbox.emails.find_by_external_id(message_id) || 
      inbox.emails.create(external_id: message_id).update_from_gmail(email)
  end

  def message_id
    email.message.message_id
  end
  
end