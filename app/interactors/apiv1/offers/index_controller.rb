class Apiv1::Offers::IndexController < Apiv1::BaseController
  def index
    render json: { offers: _fake_offers }
  end
  private
  def _fake_offers
    2.upto(2 + rand(6)).map  { |i| _fake_offer i }
  end
  def _fake_offer(i)
    {
      id: rand(99),
      account_id: i,
      listing_id: _list_id,
      price: 1.to_f / (1 + rand(99)),
      incoterm: ["FAS", "EXW", "CFR", "CIP", "CIF"].sample,
      location: Faker::Address.city + " port",
      email_subject: Faker::Company.bs,
      email_content: Faker::Lorem.sentence
    }
  end
  def _list_id
    params[:listing_id] || rand(9)
  end
end