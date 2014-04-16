class Conversations::Companies::Interactor < InteractorBase
  Fields = [
    :company_name,
    :offer_type
  ]
  attr_accessor :conversation, :attributes, :company
  attr_hash_accessor *Fields
  delegate :negotiation,
    :email,
    to: :conversation

  delegate :merchant,
    to: :negotiation

  def initialize(conversation)
    @conversation = conversation
  end

  def conversation!
    _my_result _contacts && _update_offer
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

  def _contacts
    @contacts ||= _contact_params.map do |p|
      _company.contacts.find_or_create_by! p
    end
  end

  def _contact_params
    _from.map do |f|
      {
        name: f.name,
        email: "#{f.mailbox}@#{f.host}"
      }
    end
  end

  def _from
    email.from
  end
end