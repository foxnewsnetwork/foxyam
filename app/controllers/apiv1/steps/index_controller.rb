class Apiv1::Steps::IndexController < Apiv1::Steps::ShowController
  def index
    render json: { steps: _fake_steps }
  end
  private
  def _fake_steps
    _step_names.map { |name| _fake_step.tap { |hash| hash[:step_name] = name } }
  end
end