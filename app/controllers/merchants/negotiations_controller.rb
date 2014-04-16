class Merchants::NegotiationsController < ApplicationController
  expose(:presenter) { _presenter }
  def index; end

  private
  def _presenter
    @presenter ||= Merchants::Negotiations::Presenter.new _merchant
  end

  def _merchant
    @merchant ||= FoxYam::Merchant.find params[:merchant_id]
  end
end