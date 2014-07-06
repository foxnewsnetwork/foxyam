class Apiv1::Offers::ShowController < Apiv1::BaseController
  def show
    render json: { offer: _spoof_output }
  end
  private
  def _spoof_output
    {
      id: rand(99),
      account_id: _acct_id,
      listing_id: _list_id,
      fulfilment_id: _fulfilment_id,
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

  def _acct_id
    params[:account_id] || 2
  end

  def _fulfilment_id
    params[:fulfilment_id] || rand(999)
  end
end