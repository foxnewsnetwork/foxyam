class FoxYam::Contracts::OutboundEmails::MailPresenter
  attr_accessor :request
  def initialize(request)
    @request = request
  end

  def mail_attributes
    throw :NotImplemented
  end
end