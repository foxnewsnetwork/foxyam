class Factories::Company < Factories::Base
  attr_accessor :merchant

  def initialize
    @merchant = Factories::Merchant.mock
  end

  def belongs_to(thing)
    tap do |f|
      f.merchant = thing if thing.is_a? FoxYam::Merchant
    end
  end

  def attributes
    { 
      merchant: merchant,
      company_name: Faker::Company.name
    }
  end
end