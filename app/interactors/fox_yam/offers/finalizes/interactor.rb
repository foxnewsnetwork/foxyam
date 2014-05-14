class FoxYam::Offers::Finalizes::Interactor < InteractorBase
  Fields = [
    :agreed
  ].freeze
  attr_accessor :attributes, :offer
  attr_hash_accessor *Fields
  validates :agreed,
    presence: true
  
  delegate :negotiation,
    :merchant,
    to: :presenter

  def initialize(offer)
    @offer = offer
  end
  def presenter
    @presenter ||= FoxYam::Offers::Finalizes::Presenter.new offer
  end
  def finalize!
    FoxYam::ResultBase.new valid? && _finalize_merchant_offer
  end
  private
  def _finalize_merchant_offer
    _default_line_item
  end
  def _default_line_item
    offer.line_items.first || _create_default_line_item
  end
  def _create_default_line_item
    offer.line_items.create! _line_item_params
  end
  def _line_item_params
    _line_item_presenter.attributes
  end
  def _line_item_presenter
    @line_item_presenter ||= FoxYam::Offers::Finalizes::LineItemPresenter.new offer
  end
end