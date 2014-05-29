class Queues::EmailScrapJob < Queues::EmailDeliveryJob
  @queue = :email_scrap

  def self.perform(acc_id)
    new(acc_id).perform
  end

  def initialize(req_id=nil)
    @scrap_request ||= Queues::EmailScrapRequest.find_by_id(req_id) if req_id.present?
  end

  def work
    _attempt_email_scrap
    _log_scrap_status
  end
  
  private
  def _attempt_email_scrap
    begin
      @stored_emails ||= _interactor.store_unread_emails
    rescue e
      @error = e
    end
  end
  def _log_scrap_status
    return _fulfilment.succeed! if @error.blank?
    return _fulfilment.failed!
  end
  def _fulfilment
    _request.inprogress_fulfilment
  end
  def _interactor
    @interactor ||= ::EmailInboxInteractor.new(_account)
  end
  def _account
    _request.email_account
  end
  def _request
    @scrap_request ||= Queues::EmailScrapRequest.try_first_unattempted
  end
end