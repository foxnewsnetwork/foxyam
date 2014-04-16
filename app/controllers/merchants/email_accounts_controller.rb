class Merchants::EmailAccountsController < ApplicationController
  expose(:presenter) { _get_presenter }
  def index; end
  private
  def _presenter
    @presenter ||= Merchants::EmailAccounts::Presenter.new _merchant
  end

  def _option_params
    params.permit(*Merchants::EmailAccounts::Presenter::Options)
  end
  
  def _get_presenter
    _presenter.tap do |i|
      i.options = _option_params
    end
  end

  def _merchant
    @merchant ||= FoxYam::Merchant.find params[:merchant_id]
  end

end