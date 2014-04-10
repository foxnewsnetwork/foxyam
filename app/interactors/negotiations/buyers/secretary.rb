class Negotiations::Buyers::Secretary

  attr_accessor :company
  def initialize(negotiation)
    @negotiation = negotiation
  end

  def write(language=:en)
    [_header, _body, _footer].join "\r\n\r\n"
  end

  def subject(language=:en)
    "#{_quantity} #{_units} of #{_material} - #{_place}"
  end

  private
  def _quantity
    _quantity_object.try(:quantity)
  end
  def _units
    _quantity_object.try(:units)
  end
  def _quantity_object
    @negotiation.quantities.first
  end
  def _material
    _material_object.try :material
  end
  def _material_object
    @negotiation.materials.first
  end
  def _place
    _place_object.try(:name)
  end
  def _place_object
    _price_object.try :place
  end
  def _price_object
    @negotiation.sell_prices.first
  end
  def _contact
    company.primary_contact || company.contacts.first
  end
  def _header
    "To #{_contact.try :name},"
  end
  def _body
    [_packing_weight, _pleasantry].reject(&:blank?).join "\r\n\r\n"
  end
  def _packing_weight
    [:packing_weight_pounds, :container_size].map do |key|
      _packing_weight_object.try key
    end.reject(&:blank?).join( ' / ' )
  end
  def _packing_weight_object
    @negotiation.packing_weights.first
  end
  def _pleasantry
    I18n.t(:please_thoroughly_review_and_give_me_a_price)
  end
  def _footer
    [I18n.t(:sincerely), _me].join "\r\n\r\n"
  end
  def _me
    @negotiation.merchant.name
  end
end