class Apiv1::Activities::IndexController < Apiv1::BaseController

  def index
    render json: { activities: _activities_json }
  end
  private
  def _activities_json
    1.upto(6).to_a.map { _activity_json }
  end
  def _activity_json
    {
      id: params[:id] || rand(889),
      activity_type: ["offer", "counteroffer", "listing", "fulfilment"].sample,
      action_id: params[:action_id] || rand(999),
      related_pic:"emoji/#{1 + rand(800)}.png",
      account_id: params[:account_id] || rand(999),
      related_account_id: params[:related_account_id] || rand(999),
      material_name: ["dog food", "hdpe-n", "ldpe film", "ceramic cups", "pp toys"].sample,
      price_number: (1.0 / (1 + rand(9))),
      location_name: ["LA port", "Hollywood", "Oakland Port", "Seattle Port"].sample,
      incoterm_name: ["fas", "cif", "cfr", "fob", "exw"].sample,
      fulfilment_action_name: ["escrow funded", "bill of lading uploaded", "weight ticket uploaded"].sample,
      fulfilment_summary: ["$43,000 for pp trays", "master bill of lading", "CAT certified"].sample
    }
  end
end