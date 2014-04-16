class Merchants::EmailAccounts::Interactor < InteractorBase
  Fields = [
    :email,
    :password
  ]
  attr_accessor :attributes, :merchant
  attr_hash_accessor *Fields
  validates :email,
    :password,
    presence: true

  validates :email,
    format: { with: Devise.email_regexp }

  def accounts
    merchant.email_accounts
  end
  def initialize(merchant)
    @merchant = merchant
  end

  def account!
    valid? && account
  end

  def account
    @account ||= merchant.email_accounts.find_or_create_by email_address: email,
      unencrypted_password: password
  end
end