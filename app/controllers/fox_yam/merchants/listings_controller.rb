class FoxYam::Merchants::ListingsController < FoxYam::BaseController
  expose(:interactor) { _interactor }
  def new; end
  def create
    _make_listing!
    _set_flash!
    _get_out_of_here!
  end
  private
  def _make_listing!
    @result = _creative_interactor.listing!
  end
  def _set_flash!
    flash[:success] = I18n.t(:listing_created) if @result.success?
    flash[:error] = I18n.t(:unable_to_create) if @result.failed?
  end
  def _get_out_of_here!
    return redirect_to listing_tags_path(_interactor.conversation) if @result.success?
    render :new
  end
  def _interactor
    @interactor ||= FoxYam::Merchants::Listings::Interactor.new _merchant
  end
  def _merchant
    @merchant ||= FoxYam::Merchant.find params[:merchant_id]
  end 
  def _creative_interactor
    _interactor.tap do |i|
      i.attributes = _listing_params
    end
  end
  def _listing_params
    params.require(:listings).permit(*FoxYam::Merchants::Listings::Interactor::Fields)
  end
end