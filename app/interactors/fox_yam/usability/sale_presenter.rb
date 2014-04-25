class FoxYam::Usability::SalePresenter
  Materials = ['AG LDPE Film', 'HDPE-N Milk Jugs', '#1-7 Mixed Bottles', 'ABS Regrind'].freeze
  attr_accessor :merchant, :seller
  def initialize(merchant: merchant, seller: seller)
    @merchant, @seller = merchant, seller
  end

  def seller_email
    _seller_account.email_address
  end

  def seller_password
    _seller_account.unencrypted_password
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
    seller.name
  end
  private
  def _email_account
    merchant.email_accounts.first
  end
  def _seller_account
    seller.email_accounts.first
  end
end