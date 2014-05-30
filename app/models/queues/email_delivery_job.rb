class Queues::EmailDeliveryJob
  class << self
    def email_account
      @email_account ||= ::FoxYam::EmailAccount.global_trade_payment_account
    end
  end
  @queue = :email_delivery
  
  def self.perform(req_id=nil)
    new(req_id).perform
  end

  def initialize(req_id=nil)
    @delivery_request ||= Queues::EmailDeliveryRequest.find_by_id(req_id) if req_id.present?
  end

  def work
    _log_delivery_status && _attempt_email_delivery 
  end
  alias_method :perform, :work

  private
  def _attempt_email_delivery
    @delivery_result ||= FunctionalSupport::Either.fmap(_either_mail_object) { |mail| _deliver_email mail }
  end

  def _inbox_interactor
    @inbox_interactor ||= EmailInboxInteractor.new(self.class.email_account)
  end

  def _deliver_email(mail)
    _inbox_interactor.deliver! mail
  end

  def _either_mail_object
    @either_mail_object ||= _mail_class.try _mailer_method, _request
  end

  def _log_delivery_status
    return _log_delivery_success if _attempt_email_delivery.right?
    return _log_delivery_failure
  end

  def _log_delivery_success
    _inprogress_fulfilment.succeed!
  end
  def _log_delivery_failure
    _inprogress_fulfilment.failed!
  end

  def _inprogress_fulfilment
    @inprogress_fulfilment ||= _request.inprogress_fulfilment || _request.all_fulfilments.create!(tried_at: DateTime.now)
  end
  
  def _mailer_method
    _request.mailer_method
  end

  def _request
    @delivery_request ||= Queues::EmailDeliveryRequest.try_first_unattempted
  end

  def _mail_class
    @either_mail_class ||= begin
      FunctionalSupport::Either.right _request.mailer_class.constantize
    rescue NameError => e
      FunctionalSupport::Either.left e
    end
  end
end