class FoxYam::Usability::SetupInteractor

  def actionmail
    _seller_interactor.actionmail
  end
  def setup!
    _seller_interactor.sell_email_to_merchant
  end
  private
  def _merchant
    @merchant ||= _preload_accounts && FoxYam::Merchant.preload_by("Crawling Chaos Company")
  end

  def _preload_accounts
    @preloaded_accounts ||= FoxYam::EmailAccount.preload
  end

  def _seller_interactor
    @seller_interactor ||= FoxYam::Usability::CompanyInteractor.new _merchant
  end
end