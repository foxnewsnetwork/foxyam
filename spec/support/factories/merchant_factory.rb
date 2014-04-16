class Factories::Merchant < Factories::Base
  def attributes
    { name: Faker::Company.name }
  end
end