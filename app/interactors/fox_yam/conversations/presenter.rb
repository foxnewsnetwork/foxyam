class FoxYam::Conversations::Presenter
  attr_accessor :conversation
  delegate :company,
    :offer,
    :negotiation,
    :tags,
    :via,
    :email,
    :attachments,
    to: :conversation

  delegate :merchant,
    to: :negotiation
  def initialize(conversation)
    @conversation = conversation
  end
  def company_name
    company.try :company_name
  end
  def merchant_name
    merchant.name
  end
  def conversation_date
    conversation.created_at
  end

  def via_gmail?
    'gmail'.freeze == via
  end

  def attachments?
    attachments.present?
  end

  def email_external_id
    return if email.blank?
    email.try(:email_external_id) || email.id
  end
end