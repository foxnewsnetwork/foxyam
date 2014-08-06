class Apiv1::QuantityStatistics::ShowController < Apiv1::BaseController
  def show
    render json: { quantity_statistic: _tag_stats }
  end

  private
  def _tag_stats
    {
      id: params[:id] || rand(999),
      dates: _date_values, 
      quantities: _quant_values
    }
  end
  def _quant_values
    1.upto(45).to_a.map do |i|
      10000 + rand(500)
    end
  end
  def _date_values
    1.upto(45).to_a.map do |i|
      i.days.ago
    end
  end
end