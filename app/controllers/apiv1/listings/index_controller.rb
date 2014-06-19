class Apiv1::Listings::IndexController < Apiv1::MaterialsController
  private
  def _presenter
    @presenter ||= Apiv1::ListingsIndex::Presenter.new _option_params
  end
end