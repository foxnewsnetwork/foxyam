class Apiv1::Listings::ShowController < Apiv1::BaseController
  def show
    render json: { listing: _presenter.to_builder.attributes! }
  end
  private
  def _presenter
    @presenter ||= Apiv1::Listings::ShowPresenter.new _negotiation
  end
  def _negotiation
    @negotiation ||= FoxYam::Negotiation.find params[:id]
  end
end