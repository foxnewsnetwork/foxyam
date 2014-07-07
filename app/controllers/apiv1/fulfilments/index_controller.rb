class Apiv1::Fulfilments::IndexController < Apiv1::Fulfilments::ShowController
  def index
    render json: { fulfilments: _fake_fulfilments }
  end
  private
  def _fake_fulfilments
    if params[:unread]
      k = rand(2) 
    else
      k = rand(13)
    end
    1.upto(k).map { _fake_fulfilment }
  end
end