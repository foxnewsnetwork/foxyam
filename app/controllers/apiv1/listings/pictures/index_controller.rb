class Apiv1::Listings::Pictures::IndexController < Apiv1::BaseController
  expose(:presenter) { _paginated_presenter }
  def index; end
  private
  def _presenter
    @presenter ||= Apiv1::Listings::Pictures::IndexPresenter.new _negotiation
  end
  def _paginated_presenter
    _presenter.tap do |p|
      p.attributes = _pagination_params
    end
  end
  def _pagination_params
    params.permit(:page, :per_page)
  end
  def _negotiation
    @negotiation ||= FoxYam::Negotiation.find params[:listing_id]
  end
end