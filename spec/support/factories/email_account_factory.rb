class Factories::EmailAccount < Factories::Base
  attr_accessor :merchant

  def belongs_to(thing)
    tap do |f|
      f.merchant = thing if thing.is_a? Merchant
    end
  end

  def initialize
    self.merchant = Factories::Merchant.mock
  end

  def attributes
    {
      email_address: Faker::Internet.email,
      unencrypted_password: Faker::Company.bs,
      merchant: merchant
    }
  end
end