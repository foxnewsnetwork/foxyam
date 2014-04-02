class EmailAccounts::EmailsController < ApplicationController
  expose(:emails) { inboxes.map(&:emails).flatten }
  expose(:inboxes) { _email_account.inboxes }
  def index; end

  private

  def _email_account
    @email_account ||= EmailAccount.first
  end
end