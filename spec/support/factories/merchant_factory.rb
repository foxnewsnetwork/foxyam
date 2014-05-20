class Factories::Merchant < Factories::Base
  class << self
    def count
      (@count ||= 0) 
      @count += 1
    end
  end
  def attributes
    { 
      name: [Faker::Company.name, self.class.count].join('-'),
      merchant_email: Faker::Internet.email
    }
  end
end