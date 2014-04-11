class EmailAccounts::EmailInboxes::Presenter
  Options = [:a].freeze

  attr_accessor :email_account, :options
  delegate :merchant,
    :email_address,
    to: :email_account
  def initialize(email_account)
    @email_account = email_account
  end

  def active_id
    email_account.id
  end

  def options
    @options ||= {}
  end

  def accounts
    merchant.email_accounts
  end

  def inboxes
    account.all_inboxes
  end

  def account
    email_account
  end
end