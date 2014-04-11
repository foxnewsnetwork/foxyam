class Merchants::EmailAccounts::Presenter
  Options = [
    :a
  ].freeze
  attr_accessor :merchant, :options
  def initialize(merchant)
    @merchant = merchant
  end

  def merchant_name
    merchant.name
  end

  def accounts
    merchant.email_accounts
  end

  def options
    @options ||= {}
  end

  def account
    accounts.find_by_id options[:a]
  end

  def emails
    inbox.emails
  end
end