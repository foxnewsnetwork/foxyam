class FoxYam::Negotiations::BuyOffers::Interactor < FoxYam::Negotiations::SellOffers::Interactor
  private
  def _offer_params
    {
      offer_type: 'buy',
      company: _company
    }
  end
end