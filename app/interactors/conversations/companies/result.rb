class Conversations::Companies::Result
  def initialize(thing)
    @thing = thing
  end

  def success?
    @thing.present?
  end
end