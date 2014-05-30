class FoxYam::Contracts::OutboundEmails::MailPresenter
  delegate :email_objects,
    to: :request
  delegate :buyer_party,
    :seller_party,
    to: :contract
  attr_accessor :request
  def initialize(request)
    @request = request
  end

  def content
    request.notes
  end

  def target_name
    seller_party.company_name
  end

  def from_name
    buyer_party.company_name
  end

  def mail_attributes
    {
      to: request.mail_to,
      from: request.mail_from,
      subject: request.mail_subject
    }
  end

  def email_object
    email_objects.first
  end

  def contract
    @contract ||= email_object.unserialize
  end
end