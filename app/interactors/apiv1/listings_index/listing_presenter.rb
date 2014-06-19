class Apiv1::ListingsIndex::ListingPresenter
  delegate :created_at,
    to: :negotiation
  attr_accessor :negotiation
  def initialize(negotiation)
    @negotiation = negotiation
  end
  def id
    _show_presenter.id
  end
  def material_name
    _show_presenter.material
  end
  def conversation_id
    _show_presenter.id
  end
  def is_private
    !_show_presenter.public?
  end
  def asking_price
    _show_presenter.asking_price
  end
  def price_unit
    "pound"
  end
  def incoterm
    _show_presenter.asking_price_term
  end
  def location_name
    _show_presenter.asking_price_place
  end
  def quantity
    _show_presenter.quantity
  end
  def quantity_unit
    _show_presenter.units
  end
  def packing_weight
    _show_presenter.packing
  end
  def transportor
    _show_presenter.packing_units
  end
  def time_interval
    _show_presenter.time_interval
  end
  private
  def _show_presenter
    @show_presenter ||= ::Negotiations::ShowPresenter.new @negotiation
  end
end