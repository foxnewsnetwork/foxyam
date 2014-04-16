class ScrapeAccounts::Interactor < InteractorBase
  attr_accessor :account
  def initialize(account)
    @account = account
  end

  def scrape!
    return unless _can_scrap?
    _update_scrape_time && _inbox_scrape
  end

  private
  def _can_scrap?
    EmailAccounts::Presenter.new(account).can_scrap?
  end
  def _inbox_scrape
    EmailInboxInteractor.new(account).store_unread_emails
  end
  def _update_scrape_time
    account.update last_mined_at: DateTime.now
  end
end