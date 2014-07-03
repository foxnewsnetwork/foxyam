class Apiv1::Accounts::ShowController < Apiv1::BaseController
  def show
    render json: { account: _mocked }
  end
  private
  def _mocked
    {
      id: params[:id],
      email: Faker::Internet.email,
      company: Faker::Company.name,
      image: _image_src
    }
  end
  def _image_id
    460 + params[:id].to_i
  end
  def _image_src
    "emoji/" + _image_id.to_s + ".png"
  end
end