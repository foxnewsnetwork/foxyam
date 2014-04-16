class Conversations::Tags::PriceInteractor < Conversations::Tags::TagInteractorBase
  Fields = [
    :place_name,
    :usd_per_pound,
    :incoterm,
    :notes
  ].freeze
  attr_hash_accessor *Fields

  private
  def _make_tag
    conversation.prices.create _tag_params
  end

  def _tag_params
    _raw_params.merge place: _place
  end

  def _place
    FoxYam::Place.find_by_permalink_or_create_by place_name
  end
    
  def _raw_params
    attributes.permit :usd_per_pound, :incoterm, :notes
  end
end