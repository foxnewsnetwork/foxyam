class FoxYam::Negotiations::BuyOffersController < FoxYam::Negotiations::SellOffersController
  private
  def _interactor
    @interactor ||= FoxYam::Negotiations::BuyOffers::Interactor.new negotiation: _negotiation,
      merchant: current_merchant
  end
  def _offer_params
    params.require(:buy_offers).permit(*FoxYam::Negotiations::BuyOffers::Interactor::Fields)
  end
end