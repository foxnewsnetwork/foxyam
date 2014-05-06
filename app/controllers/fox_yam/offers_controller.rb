class FoxYam::OffersController < FoxYam::BaseController
  expose(:presenter) { _show_presenter }
  def show; end

  private
  def _show_presenter
    @show_presenter ||= FoxYam::Offers::ShowPresenter.new _offer
  end
  def _offer
    @offer ||= FoxYam::Offer.find params[:id]
  end
end