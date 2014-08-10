class Apiv1::Discrepancies::ShowController < Apiv1::BaseController
  def show
    render json: { discrepancy: _discrepancy}
  end

  private
  def _discrepancy
    {
      id: params[:id] || rand(999),
      complaint_party_id: params[:complaint_party_id] || rand(999),
      accused_party_id: params[:accused_party_id] || rand(999),
      resolved_at: _resolution_date,
      created_at: 10.days.ago,
      full_claims: Faker::Lorem.paragraph,
      fulfilment_id: rand(999),
      claim_amount: rand(987654)
    }
  end
  def _resolution_date
    [nil, (rand 15).days.ago].sample
  end
end