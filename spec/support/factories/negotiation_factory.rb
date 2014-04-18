class Factories::Negotiation < Factories::Base
  attr_accessor :attributes
  attr_hash_accessor :merchant

  def belongs_to(thing)
    tap do |f|
      f.merchant = thing if thing.is_a? FoxYam::Merchant
    end
  end

  def initialize
    self.merchant = Factories::Merchant.mock
  end
end