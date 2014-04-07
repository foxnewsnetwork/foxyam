class Negotiations::ShowPresenter

  attr_accessor :negotiation
  def initialize(negotiation)
    @negotiation = negotiation
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

  def sell_offers
    negotiation.sell_offers
  end

  def buy_offers
    negotiation.buy_offers
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