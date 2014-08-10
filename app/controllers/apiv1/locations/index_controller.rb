class Apiv1::Locations::IndexController < Apiv1::BaseController

  def index
    render json: { locations: _locations }
  end
  private
  def _locations
    1.upto(15).map { _location }
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
end