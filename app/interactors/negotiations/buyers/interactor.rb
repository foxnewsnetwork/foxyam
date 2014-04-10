class Negotiations::Buyers::Interactor < InteractorBase
  MetaFields = [
    :company_name,
    :content,
    :subject,
    :from
  ].freeze
  Options = [
    :c,
    :per,
    :page
  ].freeze
  Fields = (MetaFields + Negotiations::Buyers::ContactsInteractor::Fields).freeze
  attr_accessor :negotiation, :attributes, :presenter
  attr_reader :options
  attr_hash_accessor *Fields
  validates *MetaFields,
    with: :presence
  delegate :merchant,
    :id,
    to: :negotiation
  def initialize(negotiation)
    @negotiation = negotiation
    @presenter = Negotiations::Buyers::Presenter.new(negotiation)
  end

  def attributes
    @attributes ||= {}
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

  def buyer!
    Negotiations::Buyers::Result.new valid? && _create_conversation_other
  end

  def dispatch_emails!
    _dispatcher.emails!
  end
  private
  def _dispatcher
    @dispatcher ||= Negotiations::Buyers::Dispatcher.new
  end
  def _create_conversation_other
    @other ||= _conversation.others.create! _other_params
  end
  def _other_params
    { notes: content }
  end
  def _conversation
    @conversation ||= _offer.conversations.create! _conversation_params
  end
  def _conversation_params
    { company: _company }
  end
  def _offer
    @offer ||= negotiation.buy_offers.find_or_create_by! _offer_params
  end
  def _offer_params
    {
      offer_type: 'buy',
      company: _company
    }
  end
  def _default_manager
    @default_manager ||= Negotiations::Buyers::DefaultManager.new do |m|
      m.options = options
      m.negotiation = negotiation
    end
  end
  def _setup_defaults
    self.attributes.merge! _default_manager.defaults
  end
  def _contacts
    begin
      @contacts ||= _contacts_interactor.contacts!
    rescue Negotiations::Buyers::ContactsInteractor::MalformedEmail => e
      errors.add :email, e.message
    end
  end
  def _contacts_interactor
    @contacts_interactor ||= Negotiations::Buyers::ContactsInteractor.new(_company) do |i|
      i.attributes = attributes.permit(*Negotiations::Buyers::ContactsInteractor::Fields)
    end
  end
  def _company
    @company ||= merchant.companies.find_by_permalink_but_create_by_company_name! company_name
  end
end