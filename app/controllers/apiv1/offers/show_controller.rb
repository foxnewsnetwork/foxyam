class Apiv1::Offers::ShowController < Apiv1::BaseController
  def show
    render json: { offer: _spoof_output }
  end
  private
  def _spoof_output
    {
      id: params[:id],
      dogs: true
    }
  end
end