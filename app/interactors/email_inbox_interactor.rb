class EmailInboxInteractor

  attr_accessor :account
  delegate :email,
    :password,
    to: :account

  def initialize(account)
    @account = account
  end

  def store_unread_emails
    unread.map do |email|
      EmailInteractor.new(email: email, inbox: inbox).store_email
    end
  end

  def inbox
    @inbox ||= account.inbox
  end

  def deliver!(mail)
    gmail.deliver! mail
  end

  def unread(k=15)
    begin
      gmail.inbox.unread(after: 1.month.ago).take(k)
    rescue Net::IMAP::BadResponseError => e
      gmail.signed_in?
      gmail.inbox.unread
    end
  end

  def gmail
    begin
      @gmail ||= Gmail.new email, password
    rescue EOFError => e
      @gmail = Gmail.new email, password
    rescue Net::IMAP::BadResponseError => e
      @gmail = Gmail.new(email, password).tap { |g| g.signed_in? }
    end
  end
end