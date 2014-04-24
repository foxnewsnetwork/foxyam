class FoxYam::Usability::CompanyInteractor

  attr_accessor :merchant
  def initialize(merchant)
    @merchant = merchant
  end

  def sell_email_to_merchant
    _company_gmail.deliver! actionmail
  end

  def actionmail
    @actionmail ||= FoxYam::Usability::CompanyMailer.sell_offer _company_presenter
  end

  private
  def _company_gmail
    @gmail ||= EmailInboxInteractor.new(_email_account).gmail
  end
  def _email_account
    @email_account ||= FoxYam::EmailAccount.find_by_email_address! actionmail.from.first
  end
  def _file_source
    Rails.root.join 'public', _attachment.filename
  end
  def _html_source
    actionmail.html_part.try(:body).try(:raw_source)
  end
  def _text_source
    actionmail.text_part.try(:body).try(:raw_source)
  end
  def _attachment
    actionmail.attachments.first
  end
  def _company_presenter
    @company_presenter ||= FoxYam::Usability::CompanyPresenter.new merchant
  end
end