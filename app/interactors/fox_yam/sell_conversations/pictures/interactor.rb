class FoxYam::SellConversations::Pictures::Interactor < FoxYam::Listings::Pictures::Interactor
  Fields = [
    :pictures
  ].freeze

  delegate :id,
    to: :negotiation

  
  def negotiation_presenter
    @negotiation_presenter ||= ::Negotiations::ShowPresenter.new negotiation
  end
end