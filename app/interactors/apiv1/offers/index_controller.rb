class Apiv1::Offers::IndexController < Apiv1::Offers::ShowController
  def index
    render json: { offers: _fake_offers }
  end
  private
  def _fake_offers
    2.upto(2 + rand(6)).map  { _spoof_output }
  end
end