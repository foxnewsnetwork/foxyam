class FoxYam::Offers::FinalizesController < FoxYam::BaseController
  before_filter :_reject_anonymous_users,
    :_select_correct_users

  expose(:interactor) { _interactor }
  def new; end

  def create
    _finalize_offer!
    _get_out_of_here!
  end
  private
  def _finalize_offer! 
    @result = _creative_interactor.finalize!
  end
  def _creative_interactor
    _interactor.tap { |i| i.attributes = _finalize_params }
  end
  def _finalize_params
    params.require(:finalizes).permit(*FoxYam::Offers::Finalizes::Interactor::Fields)
  end
  def _interactor
    @interactor ||= FoxYam::Offers::Finalizes::Interactor.new _offer
  end
  def _get_out_of_here! 
    return redirect_to offer_line_items_path(_offer) if @result.success?
    render :new
  end
  def _offer
    @offer ||= FoxYam::Offer.find params[:offer_id]
  end
  def _correct_merchant
    _interactor.merchant
  end
end