class Apiv1::Accounts::ShowController < Apiv1::BaseController
  def show
    render json: { account: _mocked }
  end
  private
  def _mocked
    {
      id: params[:id]
    }
  end
end