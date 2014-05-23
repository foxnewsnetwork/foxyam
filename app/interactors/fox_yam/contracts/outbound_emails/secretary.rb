class FoxYam::Contracts::OutboundEmails::Secretary
  attr_accessor :contract, :attributes
  attr_hash_accessor *FoxYam::Contracts::OutboundEmails::Interactor::Fields
  delegate :offer,
    :buyer_party,
    :seller_party,
    to: :contract
  delegate :negotiation,
    to: :offer
  def initialize(contract)
    @contract = contract
  end

  def defaulted_attributes
    _to && _cc && _subject && _content
    attributes
  end
  private
  def _to
    self.to ||= buyer_party.email
  end
  def _cc
    self.cc ||= seller_party.email
  end
  def _subject
    self.subject ||= [_negotiation_presentation, _item_desc, _price].join(' - ')
  end
  def _content
    self.content ||= "Dear all,\r\n\r\n" + 
      "Attached is the sales (purchase) order and contract for subject." + 
      "\r\n\r\nSincerely,\r\n\r\n" +
      "#{_nego.merchant_name} via #{ApplicationHelper.company_legal_name}"
  end
  def _negotiation_presentation
    "n#{negotiation.id}"
  end
  def _item_desc
    _nego.material
  end
  def _price
    "#{_nego.asking_price} #{_nego.asking_price_term} #{_nego.asking_price_place}"
  end
  def _nego
    @nego ||= ::Negotiations::ShowPresenter.new negotiation
  end
end