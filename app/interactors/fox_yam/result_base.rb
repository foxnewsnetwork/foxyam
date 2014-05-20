class FoxYam::ResultBase
  attr_accessor :thing
  def initialize(thing)
    @thing = thing
  end

  def success?
    @thing.present?
  end

  def failed?
    !success?
  end
end