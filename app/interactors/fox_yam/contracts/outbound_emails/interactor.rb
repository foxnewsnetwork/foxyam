class FoxYam::Contracts::OutboundEmails::Interactor < FoxYam::InteractorFoundation
  Fields = [
    :to,
    :cc,
    :bcc,
    :subject,
    :content
  ].freeze
  attr_hash_accessor *Fields
  attr_accessor :contract, :attributes
  def initialize(contract)
    @contract = contract
    _setup_defaults
  end

  def queue_outbound_email!
    _bind_result _delivery_request
  end

  def pictures_presenter
    @pictures_presenter ||= FoxYam::Contracts::OutboundEmails::PicturesPresenter.new contract
  end

  def presenter
    @presenter ||= Gtps::PreviewContracts::Presenter.new contract
  end
  private
  def _delivery_request
    @request ||= Queues::EmailDeliveryRequest.create! _request_params
  end
  def _request_params
    {
      mailer_class: 'FoxYam::Contracts::OutboundEmails',
      mailer_method: 'seller_desires_contract_confirmation',
      mail_to: to,
      mail_from: presenter.seller_email,
      mail_cc_to: cc,
      mail_bcc_to: bcc,
      mail_subject: subject
    }
  end
  def _setup_defaults
    @attributes = _secretary.tap { |s| s.attributes = attributes }.defaulted_attributes
  end
  def _secretary
    @secretary ||= FoxYam::Contracts::OutboundEmails::Secretary.new contract
  end
end