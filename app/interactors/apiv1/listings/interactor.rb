class Apiv1::Listings::Interactor < FoxYam::InteractorFoundation
  Fields = [
    :material_name,
    :is_private,
    :asking_price,
    :price_unit,
    :incoterm,
    :location_name,
    :quantity,
    :quantity_unit,
    :packing_weight,
    :transportor,
    :time_interval
  ].freeze

  attr_accessor :merchant, :attributes
  attr_hash_accessor *Fields
  def initialize(merchant)
    @merchant = merchant
  end

  def make_listing!
    _bind_result merchant && _listing
  end 

  def to_builder
    Jbuilder.new do |listing|
      listing.id _negotiation.id
      listing.conversation_id _conversation.id
      listing.(self, *Fields)
    end
  end
  private
  def _setup_result
    @setup_result ||= _setup_interactor.listing!
  end
  def _negotiation
    @negotiation ||= _setup_result && _setup_interactor.negotiation
  end
  def _listing
    _price if _has_price?
    _quantity if _has_quantity?
    _packing if _has_packing?
    _negotiation if _has_material?
  end
  def _has_material?
    [material_name, quantity, quantity_unit].all?(&:present?)
  end
  def _price 
    @price_result ||= _price_interactor.tag!
  end 
  def _has_price?
    [location_name, asking_price, incoterm].all?(&:present?)
  end
  def _quantity 
    @quantity_result ||= _quantity_interactor.tag!
  end 
  def _has_quantity?
    [quantity, quantity_unit, time_interval].all?(&:present?)
  end
  def _packing 
    @packing_result ||= _packing_interactor.tag!
  end 
  def _has_packing?
    [packing_weight, transportor].all?(&:present?)
  end
  def _conversation
    @conversation ||= _setup_result && _setup_interactor.conversation
  end
  def _setup_interactor
    @setup_interactor ||= FoxYam::Merchants::Listings::Interactor.new(merchant).tap { |i| i.attributes = _setup_params }
  end
  def _setup_params
    {
      material: material_name,
      place_name: location_name,
      negotiation_type: 'merchant_is_selling',
      privatize: is_private
    }
  end
  def _price_interactor
    @price_interactor ||= ::Conversations::Tags::Interactor.new(_conversation).tap { |i| i.attributes = _price_params }
  end
  def _price_params
    {
      tag_type: 'price',
      place_name: location_name,
      usd_per_pound: asking_price,
      incoterm: incoterm
    }
  end
  def _quantity_interactor
    @quantity_interactor ||= ::Conversations::Tags::Interactor.new(_conversation).tap { |i| i.attributes = _quantity_params }
  end
  def _quantity_params
    {
      tag_type: "quantity",
      quantity: quantity,
      units: quantity_unit,
      time_interval: time_interval
    }
  end
  def _packing_interactor
    @packing_interactor ||= ::Conversations::Tags::Interactor.new(_conversation).tap { |i| i.attributes = _packing_params }
  end
  def _packing_params
    {
      tag_type: "packing",
      packing_weight_pounds: packing_weight,
      container_size: transportor
    }
  end
end