class FoxYam::CompaniesController < FoxYam::BaseController
  expose(:presenter) { _presenter }
  def show; end

  private
  def _presenter
    @presenter ||= FoxYam::Companies::Presenter.new _company
  end
  def _company
    @company ||= FoxYam::Company.find params[:id]
  end
end