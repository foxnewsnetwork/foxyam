class Apiv1::Listings::IndexController < Apiv1::Listings::ShowController
  def index
    render json: { listings: _fake_listings }
  end
  private
  def _fake_listings
    1.upto(10).map { _fake_listing }.sort { |b,a| a[:created_at] <=> b[:created_at] }
  end
  def _fake_listing
    {
      id: params[:id] || rand(99),
      account_id: params[:account_id] || 1,
      material_name: _material_names.select(&:present?).sort.join(" ") ,
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
  def _material_names
    1.upto(1 + rand(2)).map { _material_queries.sample } +
    1.upto(1 + rand(2)).map { _query_params.sample }
  end
  def _material_queries
    ["HDPE", "LDPE", "Jug", "food", "film", "PET", "milk", "dog"]
  end
  def _query_params
    params.permit(:q)[:q].to_s.split(" ")
  end
end