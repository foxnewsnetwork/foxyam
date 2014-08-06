class Apiv1::Materials::ShowController < Apiv1::BaseController

  def show
    render json: { material: _material }
  end
  private
  def _material
    {
      id: _material_name,
      material_name: _material_name,
      description: Faker::Lorem.sentence,
      count: rand(99),
      graph_created_at: _graph_created_at
    }
  end
  def _material_name
    @material_name ||= params[:id] || ['pp black tray', 'hdpe natural', 'ldpe c-grade film'].sample
  end

  def _graph_created_at
    10.days.ago if _remotely_matches? [/pp.*black.*tray/i, /hdpe.*natural/i, /ldpe.*film/i], _material_name
  end

  def _remotely_matches?(xs, x)
    xs.any? { |regex| regex =~ x }
  end
end