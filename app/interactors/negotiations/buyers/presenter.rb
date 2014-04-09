class Negotiations::Buyers::Presenter

  attr_accessor :negotiation, :options
  delegate :merchant,
    :id,
    to: :negotiation
  def initialize(negotiation)
    @negotiation = negotiation
  end

  def potential_companies
    @companies ||= Company.all
  end

  def quantity
    _quantity.try :quantity
  end
  def quantity_units
    _quantity.try :units
  end
  def material
    _material.try(:material)
  end

  def price
    _price.try :usd_per_pound
  end

  def incoterm
    _price.try :incoterm
  end

  def place
    _place.try :name
  end

  private
  def _price
    negotiation.sell_prices.first
  end

  def _place
    _price.try(:place)
  end

  def _material
    negotiation.materials.first
  end
  def _quantity
    negotiation.quantities.first
  end
end