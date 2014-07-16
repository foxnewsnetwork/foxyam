class Apiv1::Tags::ShowController < Apiv1::Tags::IndexController
  def show
    render json: { tag: _fake_tag(["dog", "cat", "hdpe", "regrind"].sample) }
  end
end