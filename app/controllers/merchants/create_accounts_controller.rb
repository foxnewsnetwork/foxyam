class Merchants::CreateAccountsController < ApplicationController
  expose(:interactor) { _interactor }
  def new; end

  def create
    _create_account!
    _get_out_of_here!
  end
  private
  def _interactor
    @interactor ||= Merchants::EmailAccounts::Interactor.new _merchant
  end
  def _creative_interactor
    _interactor.tap do |i|
      i.attributes = _account_params
    end
  end
  def _account_params
    params.require(:email_accounts).permit *Merchants::EmailAccounts::Interactor::Fields
  end
  def _merchant
    @merchant ||= FoxYam::Merchant.find params[:merchant_id]
  end
  def _create_account!
    @account = _creative_interactor.account!
  end
  def _get_out_of_here!
    return redirect_to email_account_path(interactor.account) if @account.present?
    render :new
  end
end