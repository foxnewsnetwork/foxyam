class FoxYam::Contracts::OutboundEmailMailer < ActionMailer::Base
  def seller_desires_contract_confirmation(request)
    @presenter = FoxYam::Contracts::OutboundEmails::MailPresenter.new request
    mail @presenter.mail_attributes
  end
end
