class Apiv1::PriceStatistics::ShowController < Apiv1::BaseController
  def show
    render json: { price_statistic: _tag_stats }
  end

  private
  def _tag_stats
    {
      id: params[:id] || rand(999),
      values: _price_values
    }
  end
  def _price_values
    1.upto(45).to_a.map do |i|
      [i.days.ago, 0.07 + 1.0 / (1 + rand(99))]
    end
  end
end