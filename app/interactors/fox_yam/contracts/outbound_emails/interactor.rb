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

  def pictures_presenter
    @pictures_presenter ||= FoxYam::Contracts::OutboundEmails::PicturesPresenter.new contract
  end

  def presenter
    @presenter ||= Gtps::PreviewContracts::Presenter.new contract
  end
  private
  def _setup_defaults
    @attributes = _secretary.tap { |s| s.attributes = attributes }.defaulted_attributes
  end
  def _secretary
    @secretary ||= FoxYam::Contracts::OutboundEmails::Secretary.new contract
  end
end