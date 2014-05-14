class FoxYam::Offers::Finalizes::LineItemPresenter
  delegate :negotiation,
    to: :offer
  delegate :merchant_default_offer,
    to: :negotiation
  attr_accessor :offer
  def initialize(offer)
    @offer = offer
  end

  def name
    _negotiation_presenter.material
  end

  def price_term
    price.incoterm
  end
  
  def price_place
    price.place.try(:name)
  end

  def attributes
    { 
      item_description: description,
      weight: weight_amount,
      unit_price: price_amount
    }
  end

  def description
    "#{quantity_amount} #{quantity_unit} of #{name} at #{packing_weight_pounds} lbs per #{packing_weight_size}"
  end

  def packing_weight_size
    packing_weight.try(:container_size)
  end

  def packing_weight
    offer.packing_weights.limit(1).first || merchant_default_offer.packing_weights.limit(1).first
  end

  def packing_weight_pounds
    packing_weight.try(:packing_weight_pounds) || FoxYam::Conversations::PackingWeight::DefaultPounds
  end

  def weight_amount
    _to_pounds quantity_amount
  end

  def quantity_amount
    quantity.try(:quantity)
  end

  def quantity
    offer.quantities.limit(1).first || merchant_default_offer.quantities.limit(1).first
  end

  def quantity_unit
    quantity.try :units
  end

  def weight_unit
    'lb'.freeze
  end

  def price_amount
    price.try :usd_per_pound
  end

  def price
    offer.prices.limit(1).first
  end

  def price_unit
    'lb'.freeze
  end

  def item_total
    price_amount * weight_amount
  end

  private
  def _to_pounds(w)
    return if w.blank?
    return w if 'pounds'.freeze == quantity_unit.to_s
    return _pounds_from_short_ton w if 'short_tons'.freeze == quantity_unit.to_s
    return _pounds_from_metric_ton w if 'metric_tons'.freeze == quantity_unit.to_s
    return _pounds_from_kilogram w if 'kilograms'.freeze == quantity_unit.to_s
    return _pounds_from_container w if 'containers'.freeze == quantity_unit.to_s
    raise "Unknown Unit #{quantity_unit || 'blank'}"
  end
  def _pounds_from_short_ton(w)
    w * 2000
  end
  def _pounds_from_metric_ton(w)
    w * 2204
  end
  def _pounds_from_kilogram(w)
    w * 2.2046
  end
  def _pounds_from_container(w)
    w * packing_weight_pounds
  end
  def _negotiation_presenter
    @negotiation_presenter ||= ::Negotiations::ShowPresenter.new negotiation
  end
end