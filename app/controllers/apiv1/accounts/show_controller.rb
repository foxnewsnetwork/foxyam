class Apiv1::Accounts::ShowController < Apiv1::BaseController
  def show
    render json: { account: _mocked, locations: _locations, discrepancies: _discrepancies }
  end
  private
  def _mocked
    {
      id: params[:id],
      email: Faker::Internet.email,
      company: _some_company,
      executive_summary: Faker::Lorem.paragraph,
      image: _image_src,
      locations: _locations.map { |h| h[:id] },
      discrepancies: _discrepancies.map { |h| h[:id] }
    }
  end
  def _some_company
    if 1 == params[:id].to_i
      "Tracago Sales Company"
    else
      [Faker::Address.city, "Purchase Company"].join(" ")
    end
  end
  def _image_id
    460 + params[:id].to_i
  end
  def _image_src
    "emoji/" + _image_id.to_s + ".png"
  end
  def _locations
    @locations ||= 1.upto(rand 5).map { _location }
  end
  def _location
    {
      id: rand(9999),
      location_name: Faker::Address.city,
      permalink: Faker::Address.city,
      address1: Faker::Address.street_address,
      city: Faker::Address.city,
      state: Faker::AddressUS.state,
      country: Faker::Address.country,
      confirmed_at: 10.days.ago
    }
  end
  def _discrepancies
    @discrepancies ||= 1.upto(rand 10).map { _discrepancy }
  end
  def _discrepancy
    {
      id: rand(999),
      complaint_party_id: params[:complaint_party_id] || rand(999),
      accused_party_id: params[:accused_party_id] || rand(999),
      resolved_at: _resolution_date,
      created_at: 10.days.ago,
      complaint_summary: Faker::Lorem.sentence
    }
  end
  def _resolution_date
    [nil, (rand 15).days.ago].sample
  end
end