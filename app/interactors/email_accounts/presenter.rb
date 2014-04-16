class EmailAccounts::Presenter
  MinimumScrapTimeInterval = 5.minutes
  delegate :merchant,
    :email_address,
    to: :email_account
  delegate :email_accounts,
    to: :merchant
  attr_accessor :email_account
  def initialize(email_account)
    @email_account = email_account
  end

  def account
    email_account
  end

  def account_id
    email_account.id
  end

  def last_scrapped_at
    email_account.last_mined_at
  end

  def can_scrap?
    return true if last_scrapped_at.blank?
    last_scrapped_at < MinimumScrapTimeInterval.ago
  end

  def future_scrap_at
    return DateTime.now if last_scrapped_at.blank?
    last_scrapped_at + MinimumScrapTimeInterval
  end
end