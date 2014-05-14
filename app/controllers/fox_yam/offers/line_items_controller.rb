class FoxYam::Offers::LineItemsController < FoxYam::Offers::FinalizesController

  def index; end

  def create
    _create_line_item!
    _get_out_of_here!
  end

  private
  def _create_line_item!
    @result = _creative_interactor.line_item!
  end
  def _creative_interactor
    _interactor.tap do |i|
      i.attributes = _line_item_params
    end
  end
  def _line_item_params
    params.require(:line_items).permit(*FoxYam::Offers::LineItems::Interactor::Fields)
  end
  def _get_out_of_here!
    return redirect_to offer_line_items_path(_offer) if @result.success?
    render :index
  end
  def _interactor
    @interactor ||= FoxYam::Offers::LineItems::Interactor.new _offer
  end
end