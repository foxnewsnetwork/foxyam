class EmailInboxes::Emails::Presenter
  Options = [:a].freeze

  attr_accessor :email_inbox, :options
  delegate :account, 
    to: :email_inbox
  delegate :merchant,
    :email_address,
    to: :account
  def initialize(email_inbox)
    @email_inbox = email_inbox
  end

  def active_inbox
    email_inbox
  end

  def options
    @options ||= {}
  end

  def inbox_name
    email_inbox.name
  end

  def inboxes
    account.all_inboxes
  end

  def unclaimed_emails
    active_inbox.unclaimed_emails
  end

  def claimed_emails
    active_inbox.claimed_emails
  end
end