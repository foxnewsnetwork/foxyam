class Negotiations::Offers::Presenter

  attr_accessor :offer
  delegate :company,
    :others,
    :conversations,
    to: :offer
  def initialize(offer)
    @offer = offer
  end

  def company_name
    company.try(:company_name) || I18n.t(:unknown)
  end

  def id
    offer.id
  end

  def price_term
    "#{incoterm} #{place_name}"
  end

  def place_name
    return if _price.blank? || _price.place.blank?
    return _price.place.name
  end

  def incoterm
    return if _price.blank?
    _price.incoterm.upcase
  end

  def prices
    _prices
  end
  private
  def _place_name

  end
  def _price
    _prices.first
  end
  def _prices
    offer.prices.order('id desc')
  end
end