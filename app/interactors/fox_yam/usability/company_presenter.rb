class FoxYam::Usability::CompanyPresenter
  Materials = ['AG LDPE Film', 'HDPE-N Milk Jugs', '#1-7 Mixed Bottles', 'ABS Regrind'].freeze
  attr_accessor :merchant
  def initialize(merchant)
    @merchant = merchant
  end

  def smtp_user
    merchant_email
  end
  def smtp_password
    _email_account.unencrypted_password
  end

  def merchant_email
    _email_account.email_address
  end
  def recipient
    merchant.name
  end
  def subject
    @subject ||= "#{quantity} loads of #{material} - #{location}"
  end

  def quantity
    @quantity ||= 1 + rand(100)
  end
  def material
    @material ||= Materials[rand Materials.length]
  end
  def location
    @location ||= "Long Beach, CA"
  end
  def writer
    "Fred the Seller"
  end
  private
  def _email_account
    merchant.email_accounts.first
  end
end