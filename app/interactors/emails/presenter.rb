class Emails::Presenter

  attr_accessor :email, :merchant
  delegate :account,
    :inbox,
    :subject,
    to: :email
  delegate :all_inboxes,
    to: :account
  def initialize(email, merchant=nil)
    @email = email
    @merchant = merchant
  end

  def email_address
    inbox.email_address
  end

  def inbox_name
    inbox.name
  end

  def negotiation
    inbox.negotiation
  end

  def email_html
    Kramdown::Document.new(email.plain_content).to_html.html_safe
  end
end