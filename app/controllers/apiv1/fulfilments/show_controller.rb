class Apiv1::Fulfilments::ShowController < Apiv1::BaseController
  def show 
    render json: { fulfilment: _fake_fulfilment }
  end
  private
  def _fake_fulfilment
    { 
      id: params[:id] || rand(99),
      account_id: params[:account_id] || rand(99),
      offer_id: params[:offer_id] || rand(999),
      status_icon: ["done", "inprogress"].sample,
      money_amount: rand(99999),
      transfer_type: ["deposit", "withdrawal", "sale", "purchase"].sample,
      transacted_goods: ["dog food", "cherries", "watermelons", "cabbages", "horses"].sample,
      transaction_party: _some_company,
      created_at: rand(72).hours.ago
    }
  end
  def _some_company
    [Faker::Address.city, "Company"].join " "
  end
end