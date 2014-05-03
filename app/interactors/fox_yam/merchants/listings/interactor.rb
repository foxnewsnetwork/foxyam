class FoxYam::Merchants::Listings::Interactor < InteractorBase
  Fields = [
    :material,
    :place_name,
    :negotiation_type,
    :privatize
  ]
  attr_accessor :merchant, :attributes, :negotiation, :company, :conversation, :offer
  attr_hash_accessor *Fields

  validates *Fields,
    with: :presence

  validates :negotiation_type,
    inclusion: { in: FoxYam::Negotiation::NegotiationTypes.map(&:to_s) } 

  validates :_offer_type,
    inclusion: { in: FoxYam::Offer::OfferTypes.map(&:to_s) }

  def initialize(merchant)
    @merchant = merchant
  end

  def listing!
    FoxYam::Merchants::Listings::Result.new valid? && _listing_parts
  end

  private
  def _raw_negotiation
    @negotiation ||= _untyped_negotiation.tap { |n| n.update! negotiation_type: negotiation_type }
  end
  def _listing_parts
    _tags
  end
  def _publicize?
    privatize.blank?
  end
  def _negotiation
    _raw_negotiation.update public_at: DateTime.now if _publicize?
    _raw_negotiation
  end
  def _untyped_negotiation
    merchant.negotiations.create!(public_at: DateTime.now)
  end
  def _offer
    @offer ||= _negotiation.offers.create! _offer_params
  end
  def _offer_params
    {
      offer_type: _offer_type,
      company: _company
    }
  end
  def _offer_type
    return 'buy' if 'merchant_is_buying' == negotiation_type
    return 'sell' if 'merchant_is_selling' == negotiation_type
  end
  def _company
    @company ||= merchant.companies.find_by_permalink_but_create_by_company_name! merchant.name
  end

  def _conversation
    @conversation ||= _offer.conversations.create! via: :fox_yam, company: _company
  end
  def _tags
    @tags ||= _tag_interactor.tag!
  end
  def _tag_interactor
    @tags_interactor ||= ::Conversations::Tags::Interactor.new(_conversation).tap do |i|
      i.attributes = _tag_params
    end
  end
  def _tag_params
    attributes.permit(:place_name, :material).merge tag_type: :material
  end
end