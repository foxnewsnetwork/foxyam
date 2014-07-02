class Apiv1::Sessions::CreateController < Apiv1::BaseController
  def create
    render json: { session: _mocked }
  end
  private
  def _mocked
    {
      id: 1,
      email: _raw_params[:email],
      result: :success
    }
  end
  def _raw_params
    params.require(:session).permit(:email, :password)
  end
end