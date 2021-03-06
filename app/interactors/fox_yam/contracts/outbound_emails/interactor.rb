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
    _bind_result _request_object && _delivery_request
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
  def _request_object
    @request_object ||= _delivery_request.email_objects.create! _serialize_contract
  end
  def _serialize_contract
    {
      external_name: contract.class.to_s,
      external_id: contract.id
    }
  end
  def _request_params
    {
      mailer_class: 'FoxYam::Contracts::OutboundEmailMailer',
      mailer_method: 'seller_desires_contract_confirmation',
      mail_to: to,
      mail_from: presenter.seller_email,
      mail_cc_to: cc,
      mail_bcc_to: bcc,
      mail_subject: subject,
      notes: content
    }
  end
  def _setup_defaults
    @attributes = _secretary.tap { |s| s.attributes = attributes }.defaulted_attributes
  end
  def _secretary
    @secretary ||= FoxYam::Contracts::OutboundEmails::Secretary.new contract
  end
end