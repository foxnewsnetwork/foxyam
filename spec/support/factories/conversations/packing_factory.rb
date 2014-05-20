class Factories::Conversations::Packing < Factories::Conversations::Material
  def attributes
    {
      packing_weight_pounds: rand(99),
      container_size: FoxYam::Conversations::PackingWeight::ContainerSizeTypes.sample,
      notes: Faker::Lorem.sentence
    }
  end
end