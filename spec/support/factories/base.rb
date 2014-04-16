class Factories::Base
  class << self
    def belongs_to(thing)
      new.belongs_to(thing)
    end

    def mock
      new.create
    end
  end
  def create
    _creator.create! attributes
  end
  alias_method :mock, :create

  def attributes
    throw :NotImplemeneted
  end

  private

  def _creator
    self.class.to_s.split("::").tail.reduce(FoxYam) do |cc, name|
      begin
        if cc.blank?
          const_get name 
        else
          cc.const_get name
        end
      rescue TypeError => e
        e.messages += "Current class: #{cc}\n"
        e.messages += "Requested name: #{name}"
        raise e
      end
    end
  end
end

module Factories::Conversations; end
module Factories::Conversations::Companies; end