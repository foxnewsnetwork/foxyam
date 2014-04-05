class Conversations::Tags::Result
  
  def initialize(tag=nil)
    @tag = tag
  end

  def success?
    @tag.present?
  end
end