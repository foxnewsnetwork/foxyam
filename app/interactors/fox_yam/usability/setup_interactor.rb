class FoxYam::Usability::SetupInteractor

  def actionmail
    _seller_interactor.actionmail
  end
  def setup!
    _seller_interactor.sell_email_to_merchant
  end
  private
  def _merchant
    @merchant ||= _preload_accounts && FoxYam::Merchant.preload_by("Gumi Merchant Company")
  end

  def _seller
    @seller ||= FoxYam::Merchant.preload_by("Cthulhu Product Sales Company")
  end

  def _buyer
    @buyer ||= FoxYam::Merchant.preload_by("Nyarlathotep Purchasing Company")
  end

  def _preload_accounts
    @preloaded_accounts ||= FoxYam::EmailAccount.preload
  end

  def _seller_interactor
    @seller_interactor ||= FoxYam::Usability::SaleInteractor.new merchant: _merchant, seller: _seller
  end
end