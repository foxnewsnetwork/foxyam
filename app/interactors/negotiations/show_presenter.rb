class Negotiations::ShowPresenter
  Fields = [
    :per,
    :page,
    :s
  ]
  attr_accessor :negotiation, :attributes
  attr_hash_accessor *Fields
  delegate :id,
    :merchant,
    :buyers,
    :sellers,
    :sell_offers,
    :buy_offers,
    :attachments,
    :public?,
    :sale_type?,
    :buy_type?,
    :merchant_default_offer,
    to: :negotiation

  delegate :latest_price,
    to: :merchant_default_offer
  def initialize(negotiation)
    @negotiation = negotiation
  end

  def navclass(thing)
    c = 'list-group-item'
    c += ' active' if thing == s
    c += ' active' if thing =='summary' && s.blank?
    c
  end

  def asking_price
    return if merchant_default_offer.blank?
    latest_price.try(:usd_per_pound)
  end

  def asking_price_term
    return if merchant_default_offer.blank?
    latest_price.try(:incoterm)
  end

  def asking_price_place
    return if merchant_default_offer.blank?
    latest_price.try(:place_name)
  end

  def merchant_name
    merchant.name
  end

  def first_attachment_url
    attachments.first.try(:the_file).try(:url)
  end

  def seller
    sellers.first
  end

  def seller_id
    seller.try(:id)
  end

  def best_purchase_price
    purchase_prices.sort { |a,b| b.usd_per_pound <=> a.usd_per_pound }.first
  end

  def best_purchase_price?
    best_purchase_price.present?
  end

  def purchase_prices
    negotiation.sell_prices
  end

  def seller_name
    seller.try(:company_name)
  end

  def query(params)
    @attributes = (@attributes || {}).merge params
    @attributes.symbolize_keys!
    self
  end

  def material
    _material_tags.last.try(:material) || I18n.t(:unknown)
  end

  def place
    _material_tags.last.try(:place)
  end

  def quantity
    _quantity_number _quantity_tags.last
  end

  def units
    _quantity_tags.last.try(:units)
  end

  def packing
    _packing_presentation _packing_tags.last
  end

  def sell_presenters
    sell_offers.map { |offer| Negotiations::Offers::Presenter.new offer }
  end

  def buy_presenters
    buy_offers.map { |offer| Negotiations::Offers::Presenter.new offer }
  end

  def packing_units
    return if _packing_tags.last.blank?
    "lbs/#{_packing_tags.last.try(:container_size) || '40ST'}"
  end

  private
  def _packing_presentation(tag)
    return I18n.t(:unknown) if tag.blank?
    tag.packing_weight_pounds
  end

  def _packing_tags
    negotiation.packing_weights.order('id asc')
  end

  def _material_tags
    negotiation.materials.order('id asc')
  end

  def _quantity_tags
    negotiation.quantities.order('id asc')
  end

  def _quantity_number(quantity)
    return I18n.t(:unknown) if quantity.blank?
    quantity.quantity
  end
end