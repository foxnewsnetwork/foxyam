class Factories::Conversations::Quantity < Factories::Conversations::Material
  def attributes
    {
      quantity: rand(99),
      units: FoxYam::Conversations::Quantity::Units.sample,
      time_interval: FoxYam::Conversations::Quantity::TimeIntervalTypes.sample,
      notes: Faker::Lorem.sentence
    }
  end
end