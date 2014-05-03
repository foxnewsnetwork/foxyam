class Conversations::Tags::TagInteractorBase < InteractorBase
  attr_accessor :attributes, :conversation, :tag

  def initialize(conversation)
    @conversation = conversation
  end

  def tag!
    _my_result _make_tag
  end

  private
  def _my_result(tag)
    Conversations::Tags::Result.new(valid? && tag)
  end

  def _make_tag

  end
end