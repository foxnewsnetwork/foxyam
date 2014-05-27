class Queues::ScrapInteractor < FoxYam::InteractorFoundation
  attr_accessor :email_account
  def initialize(email_account)
    @email_account = email_account
  end

  def scrape!
    _bind_result _scrap_request
  end

  private
  def _scrap_request
    @request ||= Queues::EmailScrapRequest.create! _scrap_params
  end
  def _scrap_params
    { email_account: email_account }
  end
end