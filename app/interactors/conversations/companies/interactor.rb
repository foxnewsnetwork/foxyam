class Conversations::Companies::Interactor < InteractorBase
  Fields = [
    :company_name,
    :offer_type
  ]
  attr_accessor :conversation, :attributes
  attr_hash_accessor *Fields
  delegate :negotiation,
    :email,
    to: :conversation

  def initialize(conversation)
    @conversation = conversation
  end

  def conversation!
    _my_result _update_offer && _connect_contacts_with_company
  end

  private
  def _my_result(thing)
    Conversations::Companies::Result.new thing
  end

  def _update_offer
    conversation.offer.update(_offer_params) && conversation.update(company: _company)
  end

  def _connect_contacts_with_company
    _contacts.map do |contact|
      contact.update company: _company
    end
  end

  def _offer_params
    {
      offer_type: offer_type,
      company: _company
    }
  end
  def _company
    @company ||=  _existing_company || _create_company
  end

  def _existing_company
    Company.find_by_company_name(company_name)
  end

  def _create_company
    Company.create company_name: company_name, contacts: _contacts
  end

  def _contacts
    @contacts ||= _contact_params.map do |p|
      Contact.find_or_create_by p
    end
  end

  def _contact
    _contacts.select { |c| c.company.present? }.first || _contacts.first
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