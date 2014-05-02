class FoxYam::Negotiations::NegotiationTypesInteractor < InteractorBase
  validates :offer,
    :offer_type,
    with: :presence

  delegate :offer_type,
    :offer_to_buy?,
    :offer_to_sell?,
    to: :offer
  attr_accessor :negotiation
  def initialize(negotiation)
    @negotiation = negotiation
  end

  def negotiate_type!
    return unless valid?
    return _merchant_is_selling! if offer_to_sell?
    return _merchant_is_buying! if offer_to_buy?
  end

  def offer
    negotiation.offers.order("id desc").first
  end

  private
  def _merchant_is_selling!
    negotiation.update! negotiation_type: 'merchant_is_selling'
  end
  def _merchant_is_buying!
    negotiation.update! negotiation_type: 'merchant_is_buying'
  end
end