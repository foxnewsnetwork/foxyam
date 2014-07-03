class Apiv1::Conversations::IndexController < Apiv1::BaseController
  def index
    render json: { conversations: _fake_convos }
  end
  private
  def _fake_convos
    1.upto(rand 10).map { _fake_convo }.sort { |a,b| b[:created_at] <=> a[:created_at] }
  end
  def _fake_convo
    {
      id: params[:id] || rand(99),
      account_id: _acct_id,
      offer_id: params[:offer_id] || rand(88),
      created_at: rand(72).hours.ago,
      icon_type: ["fa-envelope", "fa-phone", "fa-skype"].sample,
      summary: Faker::Lorem.sentence
    }
  end
  def _acct_id
    [params[:account_id], 1].reject(&:blank?).sample
  end
end