class FoxYam::ResultBase
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