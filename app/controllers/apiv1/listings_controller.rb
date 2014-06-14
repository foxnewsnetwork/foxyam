class Apiv1::ListingsController < Apiv1::BaseController
  def create
    _create_listing
    render json: { listing: _interactor.to_builder.attributes! }
  end
  private
  def _interactor
    @interactor ||= Apiv1::Listings::Interactor.new(current_merchant).tap { |i| i.attributes = _listing_params }
  end
  def _create_listing
    @result ||= _interactor.make_listing!
  end

  def _listing_params
    params.require(:listing).permit *Apiv1::Listings::Interactor::Fields
  end
end