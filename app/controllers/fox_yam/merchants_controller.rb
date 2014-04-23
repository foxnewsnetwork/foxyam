class FoxYam::MerchantsController < FoxYam::BaseController
  expose(:presenter) { FoxYam::Merchants::Presenter.new _merchant, current_user }
  def show; end
  private
  def _merchant
    @merchant ||= FoxYam::Merchant.find params[:id]
  end
end