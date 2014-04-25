class FoxYam::Usability::SaleInteractor
  attr_accessor :merchant, :seller
  def initialize(merchant: merchant, seller: seller)
    @merchant, @seller = merchant, seller
  end

  def sell_email_to_merchant
    _company_gmail.deliver! actionmail
  end

  def actionmail
    @actionmail ||= FoxYam::Usability::CompanyMailer.sell_offer _sale_presenter
  end

  private
  def _company_gmail
    @gmail ||= EmailInboxInteractor.new(_email_account).gmail
  end
  def _email_account
    @email_account ||= FoxYam::EmailAccount.find_by_email_address! actionmail.from.first
  end
  def _sale_presenter
    @company_presenter ||= FoxYam::Usability::SalePresenter.new merchant: merchant, seller: seller
  end
end