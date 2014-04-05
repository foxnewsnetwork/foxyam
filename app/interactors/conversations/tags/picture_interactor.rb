class Conversations::Tags::PictureInteractor < Conversations::Tags::TagInteractorBase
  Fields = [
    :picture,
    :notes
  ].freeze
  attr_hash_accessor *Fields
  
  private
  def _make_tag
    conversation.pictures.create _tag_params
  end

  def _tag_params
    attributes.permit *Fields
  end
end