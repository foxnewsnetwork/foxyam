class FoxYam::Errors
  class << self
    def merge(error1, error2)
      return error1 + error2 if error1.is_a? self
      return error2 + error1 if error2.is_a? self
      return new(error1) + error2
    end
  end
  delegate :any?,
    :all?,
    :each,
    :map,
    :reduce,
    :inject,
    :select,
    :reject,
    to: :errors

  def initialize(errors=nil)
    @errors = [errors].reject(&:blank?)
  end

  def present?
    _present_errors.present?
  end

  def blank?
    !present?
  end

  def +(error)
    merge error
  end

  def merge(error)
    return @errors.push(error) && self if error.is_a? ActiveModel::Errors
    return self.class.new(errors + error.errors) if error.is_a? self.class
    raise NameError, "#{error} is not an error"
  end

  def errors
    @errors ||= []
  end

  def messages_to_string
    errors.map(&:to_a).flatten.join('--')
  end

  private
  def _present_errors
    errors.select(&:any?)
  end
end