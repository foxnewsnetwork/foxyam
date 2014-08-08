class Apiv1::Searches::IndexController < Apiv1::BaseController
  def index
    render json: _json_results
  end
  private
  def _json_results
    {
      search: _fake_search, 
      listings: _fake_listings,
      accounts: _fake_accounts
    }
  end

  def _fake_search
    {
      id: params[:q] || "no query",
      listings: _fake_listings.map { |h| h[:id] },
      accounts: _fake_accounts.map { |h| h[:id] }
    }
  end

  def _fake_listings
    @fake_listings ||= 1.upto(rand 10).map { _fake_listing }
  end
  def _fake_listing
    {
      id: rand(999),
      account_id: params[:account_id] || 1,
      material_name: _material_name_from_query,
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
  def _fake_accounts
    @fake_accounts ||= 1.upto(rand 10).map { _fake_account }
  end
  def _fake_account
    {
      id: rand(999),
      company: _company_name_from_query,
      image: "emoji/#{rand 844}.png"
    }
  end
  def _material_name_from_query
    _zip_randomly(_queries, _material_names).join " "
  end
  def _material_names
    ["hdpe", "ldpe", "film", "regrind", "natural"].sample rand 5
  end
  def _company_name_from_query
    _queries.join(" ") + " " + ["company", "incorporated", "corporation", "conglomerate"].sample
  end
  def _queries
    params[:q].to_s.split(" ")
  end
  def _zip_randomly(xs, ys)
    (xs.sample(4) + ys).sample 7
  end
end
