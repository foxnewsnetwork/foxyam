class Apiv1::Materials::IndexController < Apiv1::Materials::ShowController

  def index
    render json: { materials: _materials }
  end
  private
  def _materials
    [_material]
  end
end