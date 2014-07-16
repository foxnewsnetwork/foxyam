class Apiv1::Tags::ShowController < Apiv1::Tags::IndexController
  class << self
    def fixture_tag(id=1)
      case id.to_i
      when 1
        {
          tag: {
            id: 1,
            full_name: 'location',
            listing_count: rand(9999),
            tags: location_tags.map {|t| t[:id] }
          },
          tags: location_tags
        }
      when 2
        {
          tag: {
            id: 2,
            full_name: 'material',
            listing_count: rand(9999),
            tags: material_tags.map {|t| t[:id] }
          },
          tags: material_tags
        }
      when 3
        {
          tag: {
            id: 3,
            full_name: "company",
            listing_count: rand(9999),
            tags: company_tags.map {|t| t[:id] }
          },
          tags: company_tags
        }
      else
        {}
      end
    end

    def location_tags
      [
        {
          id: 4,
          full_name: "location+Los Angeles Port",
          listing_count: rand(9999),
          parent_id: 1
        },
        {
          id: 5,
          full_name: "location+Oakland Port",
          listing_count: rand(9999),
          parent_id: 1
        },
        {
          id: 6,
          full_name: "location+Seattle Port",
          listing_count: rand(9999),
          parent_id: 1
        }
      ]
    end

    def material_tags
      [
        {
          id: 7,
          full_name: "material+HDPE",
          listing_count: rand(9999),
          parent_id: 2
        },
        {
          id: 8,
          full_name: 'material+LDPE',
          listing_count: rand(9999),
          parent_id: 2
        },
        {
          id: 9,
          full_name: "material+PVC",
          listing_count: rand(9999),
          parent_id: 2
        }
      ]
    end

    def company_tags
      [
        {
          id: 10,
          full_name: "company+Tracago Sales Company",
          listing_count: rand(9999),
          parent_id: 3
        }
      ]
    end
  end

  def show
    render json: _faggot_tag
  end

  private

  def _faggot_tag
    if params[:id].to_i < 4
      self.class.fixture_tag params[:id]
    else
      { tag: _fake_tag(params[:id]) }
    end
  end
end