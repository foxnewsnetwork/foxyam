class Apiv1::LocationsController < Apiv1::MaterialsController
  private
  def _presenter
    @presenter ||= Apiv1::Locations::Presenter.new _option_params
  end
end