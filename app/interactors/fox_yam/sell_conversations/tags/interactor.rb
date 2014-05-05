class FoxYam::SellConversations::Tags::Interactor < InteractorBase
  Fields = ::Conversations::Tags::Interactor::Fields.freeze
  attr_accessor :conversation, :attributes
  attr_hash_accessor *Fields
  delegate :offer,
    :negotiation,
    to: :conversation

  delegate :id,
    :merchant,
    to: :negotiation

  delegate :errors,
    :valid?,
    to: :_tag_interactor

  def initialize(conversation)
    @conversation = conversation
  end

  def tag!
    FoxYam::ResultBase.new valid? && _tag
  end

  def negotiation_presenter
    @negotiation_presenter ||= ::Negotiations::ShowPresenter.new(negotiation)
  end

  private
  def _tag
    @tag ||= _tag_interactor.tag!.tag.tag
  end
  def _tag_interactor
    @tag_interactor ||= ::Conversations::Tags::Interactor.new(conversation).tap do |i|
      i.attributes = attributes
    end
  end
end