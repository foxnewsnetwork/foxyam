class Conversations::Tags::QuantityInteractor < Conversations::Tags::TagInteractorBase
  Fields = [
    :quantity,
    :units,
    :time_interval,
    :notes
  ].freeze
  attr_hash_accessor *Fields
  
  private
  def _make_tag
    conversation.quantities.create _tag_params
  end

  def _tag_params
    attributes.permit *Fields
  end
end