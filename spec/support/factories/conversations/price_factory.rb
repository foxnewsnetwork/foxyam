class Factories::Conversations::Price < Factories::Conversations::Material
  def attributes
    {
      place_name: Faker::AddressUS.city,
      usd_per_pound: rand(99),
      incoterm: FoxYam::Conversations::Price::Incoterms.sample,
      notes: Faker::Lorem.sentence
    }
  end
end