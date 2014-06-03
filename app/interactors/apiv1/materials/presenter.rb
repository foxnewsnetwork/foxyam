class Apiv1::Materials::Presenter

  attr_accessor :page, :per_page
  def initialize(page: page, per_page: per_page)
    @page, @per_page = page, per_page
  end
  def materials
    @materials ||= _paginated_materials.map { |m| Apiv1::Materials::MaterialPresenter.new m }
  end

  private
  def _convo_materials
    @convo_materials ||= FoxYam::Conversations::Material.unique_materials
  end
  def _paginated_materials
    _convo_materials
  end
end