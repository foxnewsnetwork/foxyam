class Apiv1::Steps::ShowController < Apiv1::BaseController
  class << self
    def order_number
      @order_number ||= 0
      @order_number += 1
    end
  end

  def show
    render json: { step: _fake_step }
  end
  private
  def _fake_step
    {
      id: params[:id] || rand(999),
      fulfilment_id: params[:fulfilment_id] || rand(999),
      account_id: params[:account_id] || (1 + rand(2)),
      step_name: _step_names.sample,
      status_key: [:completed, :inprogress, :not_yet].sample,
      order_number: self.class.order_number
    }
  end
  def _step_names
    [
      "funds escrow account",
      "provides booking",
      "provides loading pictures",
      "provides weight ticket",
      "provides packing list",
      "receives payment",
      "receives goods",
      "files quality discount"
    ]
  end
end