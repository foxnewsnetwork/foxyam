class Negotiations::Buyers::Result
  def initialize(result)
    @result = result
  end

  def success?
    @result.present? && @result.is_a?(FoxYam::Conversations::Other)
  end

  def failed?
    !success?
  end
end