class Negotiations::ShowPresenter

  attr_accessor :negotiation
  delegate :id,
    :merchant,
    :buyers,
    :sellers,
    :sell_offers,
    :buy_offers,
    to: :negotiation
  def initialize(negotiation)
    @negotiation = negotiation
  end

  def seller
    sellers.first
  end

  def best_purchase_price
    purchase_prices.sort { |a,b| b.usd_per_pound <=> a.usd_per_pound }.first
  end

  def purchase_prices
    negotiation.sell_prices
  end

  def seller_name
    seller.try(:company_name)
  end

  def query(params)
    self
  end

  def material
    _material_tags.last.try(:material) || I18n.t(:unknown)
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
    negotiation.packing_weights.order('id desc')
  end

  def _material_tags
    negotiation.materials.order('id desc')
  end

  def _quantity_tags
    negotiation.quantities.order('id desc')
  end

  def _quantity_number(quantity)
    return I18n.t(:unknown) if quantity.blank?
    quantity.quantity
  end
end