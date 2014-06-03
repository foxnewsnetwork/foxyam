class Apiv1::MaterialsController < Apiv1::BaseController
  expose(:presenter) { _presenter }
  def index; end
  private
  def _presenter
    @presenter ||= Apiv1::Materials::Presenter.new _option_params
  end
  def _option_params
    params.permit(:per_page, :page)
  end
end