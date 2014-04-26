class Emails::Negotiations::Interactor < InteractorBase
  Fields = [
    :permalink
  ]
  attr_accessor :email, :attributes, :negotiation, :conversation, :merchant
  attr_hash_accessor *Fields

  validates :permalink,
    :negotiation,
    presence: true

  delegate :from_address,
    to: :email

  delegate :email_presentation,
    :email_address,
    to: :from_address
    
  def initialize(email, merchant=nil)
    @email = email
    @merchant = merchant
  end

  def email_text
    Kramdown::Document.new(email.plain_content).to_html.html_safe
  end

  def permalink_types
    ['new'] + merchant.negotiations.map(&:id)
  end

  def negotiation!
    return _new_result _look_for_negotiation if _existing_negotiation?
    return _new_result _create_offer_conversation if _new_negotiation?
    _new_result
  end

  def new?
    conversation.present? && _new_negotiation?
  end

  def existing?
    negotiation.present? && _existing_negotiation?
  end

  def inbox
    @inbox ||= _negotiation_draft.email_inboxes.find_or_create_by account: account
  end

  def account
    @account ||= email.account
  end

  private
  def _look_for_negotiation
    @negotiation ||= _merchant.all_negotiations.find_by_id! permalink
  end
  def _create_negotiation_offer
    @offer ||= _create_negotiation_and_tie_with_inbox.offers.create 
  end
  def _create_offer_conversation
    @conversation ||= _create_negotiation_offer.conversations.create email: email
  end
  def _create_negotiation_and_tie_with_inbox
    email.update(inbox: inbox) && _negotiation_draft
  end
  def _negotiation_draft
    @negotiation ||= _merchant.negotiation_draft
  end
  def _existing_negotiation?
    permalink.to_s != 'new'
  end
  def _new_negotiation?
    !_existing_negotiation?
  end
  def _merchant
    merchant || email.merchant
  end
  def _new_result(thing=nil)
    Emails::Negotiations::Result.new(valid? && thing)
  end
end