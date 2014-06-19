class Apiv1::Listings::Pictures::IndexPresenter
  attr_hash_accessor :per_page, :page
  attr_accessor :attributes
  def initialize(negotiation)
    @negotiation = negotiation
  end

  def presenters
    @presenters ||= _paginated_pictures.map do |p|
      Apiv1::Listings::Pictures::ShowPresenter.new p
    end
  end

  private
  def _capped_per_page
    per_page.to_i > 25 ? 25 : per_page
  end
  def _offset
    page.to_i * _capped_per_page.to_i
  end
  def _paginated_pictures
    _pictures.limit(_capped_per_page).offset(_offset)
  end
  def _pictures
    _offer.pictures
  end
  def _offer
    @negotiation.merchant_default_offer
  end
end