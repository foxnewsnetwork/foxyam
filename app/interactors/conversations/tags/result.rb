class Conversations::Tags::Result
  
  attr_accessor :tag
  def initialize(tag=nil)
    @tag = tag
  end

  def success?
    @tag.present?
  end
end