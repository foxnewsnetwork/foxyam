class Apiv1::Locations::Presenter < Apiv1::Materials::Presenter
  def locations
    @locations ||= _paginated_locations.map { |m| Apiv1::Locations::LocationPresenter.new m }
  end

  private
  def _convo_locations
    @convo_locations ||= FoxYam::Place.unique_permalinks
  end
  def _paginated_locations
    _convo_locations.page(page).per(per_page)
  end
end