class FoxYam::Negotiations::SellOffersController < FoxYam::BaseController
  expose(:interactor) { _interactor }
  def new; end
  def create
    _make_offer!
    _get_out_of_here!
  end
  private
  def _make_offer!
    @result = _creative_interactor.offer!
  end
  def _creative_interactor
    _interactor.tap do |i|
      i.attributes = _sell_offer_params
    end
  end
  def _sell_offer_params
    params.require(:sell_offers).permit(*FoxYam::Negotiations::SellOffers::Interactor::Fields)
  end
  def _interactor
    @interactor ||= FoxYam::Negotiations::SellOffers::Interactor.new negotiation: _negotiation,
      merchant: current_merchant
  end
  def _negotiation
    @negotiation ||= FoxYam::Negotiation.find params[:negotiation_id]
  end
  def _get_out_of_here!
    return redirect_to sell_conversation_tags_path(_interactor.conversation) if @result.success?
    render :new
  end
end