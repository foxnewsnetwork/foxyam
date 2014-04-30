class FoxYam::Merchants::Listings::Interactor < InteractorBase
  Fields = [
    :material,
    :place_name,
    :negotiation_type
  ]
  attr_accessor :merchant, :attributes, :negotiation, :company, :conversation, :offer
  attr_hash_accessor *Fields

  validates *Fields,
    with: :presence

  validates :negotiation_type,
    inclusion: { in: FoxYam::Negotiation::NegotiationTypes.map(&:to_s) }    

  def initialize(merchant)
    @merchant = merchant
  end

  def listing!
    FoxYam::Merchants::Listings::Result.new valid? && _listing_parts
  end

  private
  def _listing_parts
    _negotiation && _offer && _tags && _conversation
  end
  def _negotiation
    @negotiation ||= _untyped_negotiation.tap { |n| n.update! negotiation_type: negotiation_type }
  end
  def _untyped_negotiation
    merchant.negotiation || merchant.negotiations.create!
  end
  def _offer
    @offer ||= _negotiation.offers.create! _offer_params
  end
  def _offer_params
    {
      offer_type: negotiation_type,
      company: _company
    }
  end
  def _company
    @company ||= merchant.companies.find_by_permalink_but_create_by_company_name! merchant.name
  end

  def _conversation
    @conversation ||= _offer.conversations.create! via: :fox_yam
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