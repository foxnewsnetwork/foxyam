class Apiv1::Services::IndexController < Apiv1::BaseController

  def index
    render json: { services: _fake_services }
  end

  private

  def _fake_services
    
  end

end