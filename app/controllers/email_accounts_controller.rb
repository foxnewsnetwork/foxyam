class EmailAccountsController < ApplicationController
  expose(:email_account) { EmailAccount.find params[:id] }
  def show; end
end