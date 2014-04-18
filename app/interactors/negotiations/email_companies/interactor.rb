class Negotiations::EmailCompanies::Interactor < InteractorBase
  class << self
    def offer_types
      Conversations::Companies::Interactor.offer_types
    end
  end
  Fields = [
    :company_name,
    :offer_type
  ].freeze
  attr_accessor :attributes, 
    :negotiation, 
    :email, 
    :offer, 
    :conversation, 
    :company
  attr_hash_accessor *Fields

  delegate :merchant,
    to: :negotiation

  delegate :companies,
    to: :merchant

  delegate :inbox,
    :account,
    to: :email

  validate :offer_type,
    :company_name,
    presence: true

  validate :offer_type,
    inclusion: { in: FoxYam::Offer::OfferTypes }
  def initialize(negotiation, email)
    @negotiation, @email = negotiation, email
  end

  def presenter
    @presenter ||= Negotiations::EmailCompanies::Presenter.new self
  end

  def defaults= (params)
    self.attributes = (attributes || {}).reverse_merge _default_manager_defaults(params)
  end

  def company_negotiation_offer!
    Negotiations::EmailCompanies::Result.new _conversation && _offer && _company && _update_email
  end

  private
  def _default_manager_defaults(params)
    _default_manager.tap do |d|
      d.attributes = params
      d.merchant = merchant
      d.email = email
    end.defaults
  end
  def _default_manager
    @default_manager ||= Negotiations::EmailCompanies::DefaultManager.new
  end
  def _conversation
    @conversation ||= _offer.conversations.create! company: _company
  end
  def _offer
    return _existing_offer if _existing_offer?
    return _new_offer if _new_company?
  end
  def _existing_offer?
    negotiation.offers.exists? company: _company
  end
  def _new_company?
    !_existing_offer?
  end
  def _new_offer
    @offer ||= negotiation.offers.create! offer_type: offer_type,
      company: _company
  end
  def _existing_offer
    @offer ||= negotiation.offers.find_by_company_id _company.id
  end
  def _company
    @company ||= companies.find_by_permalink_but_create_by_company_name! company_name
  end
  def _update_email
    email.update conversation: _conversation
  end
end