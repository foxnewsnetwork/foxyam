class Negotiations::Buyers::DefaultManager

  attr_accessor :negotiation, :options
  delegate :contacts,
    to: :company

  def initialize(&block)
    yield self
  end

  def defaults
    return {} if company.blank?
    {
      company_name: company.company_name,
      to: contacts.map { |contact| contact.google_style }.join(", "),
      content: _secretary.write,
      subject: _secretary.subject
    }
  end

  def company
    @company ||= FoxYam::Company.find_by_company_name _company_name
  end

  private
  def _secretary
    @secretary ||= Negotiations::Buyers::Secretary.new(negotiation).tap do |s|
      s.company = company
    end
  end

  def _company_name
    options[:c] if options.present?
  end
end