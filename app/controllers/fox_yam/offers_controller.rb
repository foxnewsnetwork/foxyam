class FoxYam::OffersController < FoxYam::BaseController
  expose(:presenter) { _show_presenter }
  before_filter :_reject_anonymous_users,
    :_select_correct_users
  def show; end

  private
  def _correct_merchants
    [presenter.merchant_who_made_offer, presenter.merchant_being_offered]
  end
  def _show_presenter
    @show_presenter ||= FoxYam::Offers::ShowPresenter.new _offer
  end
  def _offer
    @offer ||= FoxYam::Offer.find params[:id]
  end
end