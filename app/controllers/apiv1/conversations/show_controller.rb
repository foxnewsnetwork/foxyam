class Apiv1::Conversations::ShowController < Apiv1::Conversations::ShowController
  def show
    render json: { conversation: _fake_convo }
  end
end