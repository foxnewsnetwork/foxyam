class FoxYam::Negotiations::SellOffers::Interactor < InteractorBase
  Fields = [:agreed].freeze
  attr_accessor :attributes, :negotiation, :merchant, :company, :offer, :conversation
  delegate :id,
    to: :negotiation

  def initialize(negotiation: negotiation, merchant: merchant)
    @negotiation, @merchant = negotiation, merchant
  end

  def negotiation_presenter
    @negotiation_presenter ||= ::Negotiations::ShowPresenter.new negotiation
  end

  def offer!
    FoxYam::ResultBase.new valid? && _conversation
  end

  def tags
    @conversation.try :tags
  end

  private
  def _conversation
    @conversation ||= _offer.conversations.find_or_create_by! _conversation_params
  end
  def _conversation_params
    {
      via: 'fox_yam',
      company: _company
    }
  end
  def _company
    @company ||= merchant.company_with_default
  end
  def _offer
    @offer ||= negotiation.offers.find_or_create_by! _offer_params
  end
  def _offer_params
    {
      offer_type: 'sell',
      company: _company
    }
  end
end