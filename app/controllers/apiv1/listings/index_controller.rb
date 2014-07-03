class Apiv1::Listings::IndexController < Apiv1::Listings::ShowController
  def index
    render json: { listings: _fake_listings }
  end
  private
  def _fake_listings
    1.upto(10).map { _fake_listing }.sort { |b,a| a[:created_at] <=> b[:created_at] }
  end
end