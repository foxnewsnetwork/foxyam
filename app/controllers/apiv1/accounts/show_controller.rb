class Apiv1::Accounts::ShowController < Apiv1::BaseController
  def show
    render json: { account: _mocked }
  end
  private
  def _mocked
    {
      id: params[:id],
      email: Faker::Internet.email,
      company: _some_company,
      image: _image_src
    }
  end
  def _some_company
    if 1 == params[:id].to_i
      "Tracago Sales Company"
    else
      [Faker::Address.city, "Purchase Company"].join(" ")
    end
  end
  def _image_id
    460 + params[:id].to_i
  end
  def _image_src
    "emoji/" + _image_id.to_s + ".png"
  end
end