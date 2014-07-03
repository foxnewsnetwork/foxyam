class Apiv1::Pictures::IndexController < Apiv1::BaseController
  def index
    render json: { pictures: _fake_pictures }
  end
  private
  def _fake_pictures
    1.upto(16).map { _fake_picture }
  end
  def _fake_picture
    {
      id: rand(99),
      listing_id: params[:listing_id],
      source: "emoji/" + rand(846).to_s + ".png"
    }
  end
end