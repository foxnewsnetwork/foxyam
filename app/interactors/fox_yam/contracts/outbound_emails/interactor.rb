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
  end

  def presenter
    @presenter ||= Gtps::PreviewContracts::Presenter.new contract
  end
end