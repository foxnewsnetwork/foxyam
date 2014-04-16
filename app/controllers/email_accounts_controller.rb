class EmailAccountsController < ApplicationController
  expose(:presenter){ _presenter }
  def show; end
  private
  def _presenter
    @presenter ||= EmailAccounts::Presenter.new _email_account
  end
  def _email_account
    @email_account ||= EmailAccount.find params[:id]
  end
end