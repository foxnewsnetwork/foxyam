class FoxYam::Offers::LineItems::LineItemPresenter < FoxYam::Offers::Finalizes::LineItemPresenter

  delegate :offer,
    :id,
    to: :line_item
  attr_accessor :line_item
  def initialize(line_item)
    @line_item = line_item
  end

  def description
    line_item.item_description
  end

  def weight_amount
    line_item.weight
  end

  def price_amount
    line_item.unit_price
  end

end