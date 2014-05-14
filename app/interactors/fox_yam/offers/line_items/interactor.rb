class FoxYam::Offers::LineItems::Interactor < InteractorBase
  Fields = [
    :item_description,
    :weight,
    :unit_price
  ].freeze
  attr_hash_accessor *Fields
  attr_accessor :offer, :attributes
  validates *Fields,
    presence: true
  validates :weight,
    :unit_price,
    numericality: true
  delegate :negotiation,
    :merchant,
    to: :presenter

  def initialize(offer)
    @offer = offer
  end

  def presenter
    @presenter ||= FoxYam::Offers::LineItems::Presenter.new offer
  end

  def line_item!
    FoxYam::ResultBase.new valid? && _line_item
  end

  private
  def _line_item
    @line_item ||= offer.line_items.create! attributes
  end
end