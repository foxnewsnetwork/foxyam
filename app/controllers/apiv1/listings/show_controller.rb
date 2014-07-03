class Apiv1::Listings::ShowController < Apiv1::BaseController
  def show
    render json: { listing: _fake_listing }
  end
  private
  def _fake_listings
    1.upto(10).map { _fake_listing }.sort { |b,a| a.created_at <=> b.created_at }
  end
  def _fake_listing
    {
      id: params[:id] || rand(99),
      account_id: params[:account_id] || 1,
      material_name: ["HDPE Milk Jugs", "Dog Food", "Cherries", "Watermelon"].sample ,
      is_private: false,
      asking_price: 1.to_f / (1 + rand(99)),
      price_unit: "lb",
      incoterm: ["EXW", "FAS", "CIP", "CIF"].sample,
      location_name: Faker::Address.city + " port",
      quantity: rand(40) + 1,
      quantity_unit: "containers",
      packing_weight: 36000,
      transportor: "40ST",
      time_interval: "one-time",
      created_at: rand(72).hours.ago
    }
  end
end