class EmailInboxes::EmailsController < EmailAccounts::EmailInboxesController
  private
  def _presenter
    @presenter ||= EmailInboxes::Emails::Presenter.new _email_inbox
  end

  def _email_inbox
    @email_inbox ||= FoxYam::EmailInbox.find params[:email_inbox_id]
  end

  def _option_params
    params.permit(*EmailInboxes::Emails::Presenter::Options)
  end
end