class Apiv1::QuantityStatistics::ShowController < Apiv1::BaseController
  def show
    render json: { quantity_statistic: _tag_stats }
  end

  private
  def _tag_stats
    {
      id: params[:id] || rand(999),
      values: _quant_values
    }
  end
  def _quant_values
    1.upto(45).to_a.map do |i|
      [i.days.ago, 10000 + rand(500)]
    end
  end
end