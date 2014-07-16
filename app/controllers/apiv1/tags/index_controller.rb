class Apiv1::Tags::IndexController < Apiv1::BaseController
  def index
    render json: { tags: _fake_tags }
  end
  private
  def _fake_tags
    ["location", "material", "company"].map do |c|
      _fake_tag c
    end
  end
  def _fake_tag(c)
    {
      id: params[:id] || rand(99999),
      parent_id: _parent_id,
      full_name: c,
      listing_count: rand(9999)
    }
  end
  def _parent_id
    params[:parent_id] || rand(99999)
  end
end