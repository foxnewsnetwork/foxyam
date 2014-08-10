class Apiv1::Fulfilments::ShowController < Apiv1::BaseController
  def show 
    render json: { fulfilment: _fake_fulfilment, log_entries: _log_entries }
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
      created_at: rand(72).hours.ago,
      log_entries: _log_entries.map { |h| h[:id] }
    }
  end
  def _some_company
    [Faker::Address.city, "Company"].join " "
  end
  def _log_entries
    @log_entries ||= 1.upto(rand 20).map { _log_entry }
  end
  def _log_entry
    {
      id: rand(9999),
      log_type: ["document", "picture", "statement"].sample,
      log_subject: ["fulfilment contract", "preloading picture", "weight ticket", "bill of lading"].sample,
      statement: Faker::Lorem.paragraph,
      account_id: rand(99999),
      provider_name: Faker::Company.name,
      created_at: rand(99).days.ago
    }
  end
end