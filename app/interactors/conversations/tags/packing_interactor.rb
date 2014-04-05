class Conversations::Tags::PackingInteractor < Conversations::Tags::TagInteractorBase
  Fields = [
    :packing_weight_pounds,
    :container_size,
    :notes
  ].freeze
  attr_hash_accessor *Fields

  private
  def _make_tag
    conversation.packing_weights.create _tag_params
  end

  def _tag_params
    attributes.permit *Fields
  end
end