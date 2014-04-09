class Negotiations::Buyers::Interactor < InteractorBase
  Fields = [
    :company_name,
    :from,
    :to,
    :cc,
    :bcc,
    :content,
    :subject
  ]
  Options = [
    :c,
    :per,
    :page
  ]
  attr_accessor :negotiation, :attributes, :presenter
  attr_reader :options
  attr_hash_accessor *Fields

  delegate :merchant,
    :id,
    to: :negotiation
  def initialize(negotiation)
    @negotiation = negotiation
    @presenter = Negotiations::Buyers::Presenter.new(negotiation)
  end

  def options=(os)
    return os if os.blank?
    presenter.tap { |i| i.options = os }
    @options = os
    _setup_defaults
    @options
  end

  def from_choices
    merchant.email_accounts.map(&:email_address)
  end

  private
  def _setup_defaults
    self.company_name ||= _company.company_name
    self.to ||= _contacts.map { |contact| contact.google_style }.join(", ")
    self.content ||= _secretary.write
    self.subject ||= _secretary.subject
  end

  def _secretary
    @secretary ||= Negotiations::Buyers::Secretary.new(negotiation).tap do |s|
      s.company = _company
    end
  end

  def _contacts
    _company.try(:contacts).to_a
  end

  def _company
    @company ||= Company.find_by_company_name company_name || options[:c]
  end
end