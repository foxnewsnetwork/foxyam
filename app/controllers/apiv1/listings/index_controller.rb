class Apiv1::Listings::IndexController < Apiv1::Listings::ShowController
  def index
    render json: { listings: _fake_listing }
  end
  private
  def _presenter
    @presenter ||= Apiv1::ListingsIndex::Presenter.new _option_params
  end
end