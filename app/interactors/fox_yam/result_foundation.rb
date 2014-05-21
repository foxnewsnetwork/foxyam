class FoxYam::ResultFoundation < FoxYam::ResultBase
  class << self
    def consider_unbind(something)
      return something.payload if something.is_a? self
      something
    end
  end
  def initialize(errors, thing)
    @errors, @thing = errors, thing
  end

  def success?
    errors.blank? && payload.present?
  end
  alias_method :success?, :present?
  alias_method :failed?, :blank?

  def payload
    FoxYam::ResultFoundation.consider_unbind @thing
  end
end