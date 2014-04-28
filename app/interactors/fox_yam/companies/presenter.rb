class FoxYam::Companies::Presenter
  attr_accessor :company
  delegate :merchant,
    :contacts,
    to: :company

  delegate :companies,
    :negotiations,
    to: :merchant

  def initialize(company)
    @company = company
  end

  def merchant_id
    merchant.try :id
  end

  def company_id
    company.try :id
  end

end