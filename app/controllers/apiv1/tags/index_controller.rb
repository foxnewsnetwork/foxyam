class Apiv1::Tags::IndexController < Apiv1::BaseController

  def index
    render json: { tags: _fake_tags }
  end

  private

  def _fake_tags
    case params[:parent_id].to_i
    when 0
      roots = 1.upto(3).map do |i|
        Apiv1::Tags::ShowController.fixture_tag(i)[:tag]
      end
      roots +
      Apiv1::Tags::ShowController.location_tags +
      Apiv1::Tags::ShowController.material_tags +
      Apiv1::Tags::ShowController.company_tags
    when 1
      Apiv1::Tags::ShowController.location_tags
    when 2
      Apiv1::Tags::ShowController.material_tags
    when 3
      Apiv1::Tags::ShowController.company_tags
    else
      []
    end
  end
  
end