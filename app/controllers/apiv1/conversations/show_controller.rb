class Apiv1::Conversations::ShowController < Apiv1::BaseController
  def show
    render json: { conversation: _mocked_hash }
  end
  private
  def _mocked_hash
    {
      id: 1,
      offer: 1
    }
  end
end