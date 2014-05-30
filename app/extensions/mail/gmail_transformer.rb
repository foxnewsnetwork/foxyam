class Mail::GmailTransformer

  attr_reader :email_account
  def initialize(email_account)
    @email_account = email_account
  end

  def convert_mail_to_gmail(mail)
    _gmail.compose mail
  end

  private
  def _gmail
    @gmail ||= ::EmailInboxInteractor.new(email_account).gmail
  end
end