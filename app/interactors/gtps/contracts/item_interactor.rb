class Gtps::Contracts::ItemInteractor < Gtps::Contracts::BaseInteractor
  Fields = [
    :item_description,
    :quantity,
    :quantity_unit,
    :unit_price
  ].freeze
  attr_hash_accessor *Fields
  attr_accessor :item
  validates *Fields,
    presence: true
  validates :quantity,
    :unit_price,
    numericality: true
  
  def make!
    _bind_result _valid_with_errors? { _item }
  end
  private
  def _item
    @item ||= contract.items.create! attributes.permit *Fields
  end
end