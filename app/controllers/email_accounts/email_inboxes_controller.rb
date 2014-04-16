class EmailAccounts::EmailInboxesController < Merchants::EmailAccountsController
  
  private
  def _presenter
    @presenter ||= EmailAccounts::EmailInboxes::Presenter.new _email_account
  end

  def _email_account
    @email_account ||= FoxYam::EmailAccount.find params[:email_account_id]
  end

  def _option_params
    params.permit(*EmailAccounts::EmailInboxes::Presenter::Options)
  end
end