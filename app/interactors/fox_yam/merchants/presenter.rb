class FoxYam::Merchants::Presenter

  attr_accessor :merchant, :user
  delegate :email_accounts,
    :companies,
    to: :merchant
  delegate :merchants,
    to: :user
  def initialize(merchant, user)
    @merchant = merchant
    @user = user
  end

  def merchant_id
    merchant.id
  end

end