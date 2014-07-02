class Apiv1::Accounts::CreateController < Apiv1::BaseController
  def create
    render json: { account: _fake_data }
  end
  private
  def _fake_data
    {
      id: 2,
      email: _account_params[:email],
      company: _account_params[:company]
    }
  end
  def _account_params
    params.require(:account).permit(:company, :password, :password_confirmation, :email)
  end
end