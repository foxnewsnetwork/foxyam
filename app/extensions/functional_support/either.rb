class FunctionalSupport::Either
  class AlreadyFailed < ::StandardError; end
  class << self
    def left(errors)
      new.tap do |e|
        if errors.is_a? Array
          e.errors = errors 
        else
          e.errors = [errors]
        end
      end
    end
    def right(payload)
      new.tap do |e|
        e.payload = payload
      end
    end
    # This might be hard to understand unless you've done Haskell
    # but either is an applicative functor and fmap always returns
    # another either after mapping the payload of a right either
    # using &func... if either is left or an error occurs, it returns
    # a left either
    def fmap(either, &func)
      begin
        return right yield either.payload if either.right?
        either
      rescue StandardError => e
        left e
      end
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