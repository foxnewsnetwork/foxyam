class Conversations::Companies::Interactor < InteractorBase
  Fields = [
    :company_name,
    :offer_type
  ].freeze
  attr_accessor :conversation, :attributes, :company
  attr_hash_accessor *Fields
  delegate :negotiation,
    :email,
    to: :conversation

  delegate :merchant,
    to: :negotiation

  class << self
    def offer_types
      FoxYam::Offer::OfferTypes.reverse.freeze
    end
  end
  def initialize(conversation)
    @conversation = conversation
  end

  def email_text
    Kramdown::Document.new(email.plain_content).to_html.html_safe
  end

  def conversation!
    _my_result _contact && _update_offer
  end

  private

  def _my_result(thing)
    Conversations::Companies::Result.new thing
  end

  def _update_offer
    conversation.offer.update(_offer_params) && 
    conversation.update(company: _company)
  end

  def _offer_params
    {
      offer_type: offer_type,
      company: _company
    }
  end
  def _company
    @company ||= _existing_company || _create_company
  end

  def _existing_company
    merchant.companies.find_by_company_name(company_name)
  end

  def _create_company
    merchant.companies.create! company_name: company_name
  end

  def _contact
    @contact ||= _company.contacts.find_or_create_by! _contact_params
  end

  def _contact_params
    {
      name: _from.email_presentation,
      email: _from.email_address
    }
  end

  def _from
    email.from_address
  end
end