class Conversations::Tags::MaterialInteractor < Conversations::Tags::TagInteractorBase
  Fields = [
    :material,
    :notes
  ].freeze
  attr_hash_accessor *Fields

  private
  def _make_tag
    conversation.materials.create _tag_params
  end

  def _tag_params
    attributes.permit *Fields
  end
end