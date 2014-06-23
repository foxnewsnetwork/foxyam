class Apiv1::Fulfilments::ShowController < Apiv1::BaseController
  def show 
    render json: { fulfilment: _spoofed }
  end
  private
  def _spoofed
    { 
      id: params[:id]
    }
  end
end