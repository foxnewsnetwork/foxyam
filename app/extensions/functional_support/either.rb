class FunctionalSupport::Either
  class AlreadyFailed < ::StandardError; end
  class << self
    def left(errors)
      new.tap do |e|
        e.errors = errors
      end
    end
    def right(payload)
      new.tap do |e|
        e.payload = payload
      end
    end
    def arrow_or(left_call, right_call)

    end
  end
  attr_accessor :payload, :errors
  def try(*whatevers)
    return _handle_correct(*whatevers) if right?
    return _handle_errors(*whatevers)
  end

  def right?
    !left?
  end

  def errors
    @errors ||= []
  end

  def left?
    errors.present?
  end

  def wrong?
    left?
  end
  private
  def _handle_correct(*args)
    begin
      self.class.right payload.try *args
    rescue StandardError => e
      self.class.left errors + [e]
    end
  end
  def _handle_errors(method_name, *args)
    self.class.left errors + [AlreadyFailed.new(method_name)]
  end
end