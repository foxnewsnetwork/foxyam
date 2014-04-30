class Conversations::Tags::MaterialInteractor < Conversations::Tags::TagInteractorBase
  Fields = [
    :place_name,
    :material,
    :notes
  ].freeze
  attr_hash_accessor *Fields

  private
  def _make_tag
    return conversation.materials.create! _placed_tag_params if _place?
    conversation.materials.create! _tag_params
  end

  def _place?
    place_name.present? && _place.present?
  end

  def _place
    @place ||= FoxYam::Place.find_by_permalink_or_create_by place_name
  end

  def _tag_params
    attributes.permit :material, :notes
  end

  def _placed_tag_params
    _tag_params.merge place: _place
  end
end