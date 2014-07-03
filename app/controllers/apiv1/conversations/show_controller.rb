class Apiv1::Conversations::ShowController < Apiv1::Conversations::IndexController
  def show
    render json: { conversation: _fake_convo }
  end
end