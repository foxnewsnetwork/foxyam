class FoxYam::Offers::ContractsController < FoxYam::BaseController

  def new; end
  def create
    _create_contract!
    _get_out_of_here!
  end
  private
  def _create_contract!
    @result = _creative_interactor.contract!
  end
  def _creative_interactor
    _interactor.tap do |i|
      i.attributes = _contract_params
    end
  end
  def _interactor
    @interactor ||= FoxYam::Offers::Contracts::Interactor.new _offer
  end
  def _offer
    @offer ||= FoxYam::Offer.find params[:offer_id]
  end
  def _contract_params
    params.require(:contracts)
  end
  def _get_out_of_here!
    return redirect_to new_offer_email_path(_offer) if @result.success?
    render :new
  end
end