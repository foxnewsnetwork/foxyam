class FoxYam::Offers::ContractsController < FoxYam::BaseController
  expose(:interactor) { _interactor }
  def create
    _create_contract!
    _get_out_of_here!
  end
  private
  def _create_contract!
    @result = _interactor.make_contract!
  end
  def _contract
    _interactor.contract
  end
  def _interactor
    @interactor ||= FoxYam::Offers::Contracts::Interactor.new _offer
  end
  def _offer
    @offer ||= FoxYam::Offer.find params[:offer_id]
  end
  def _get_out_of_here!
    return redirect_to preview_contract_path _contract if @result.success?
    render 'error'
  end
end