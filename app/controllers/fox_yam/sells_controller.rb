class FoxYam::SellsController < FoxYam::BaseController
  expose(:presenter) { _presenter }
  def index; end

  private
  def _presenter
    @presenter ||= FoxYam::Sells::Presenter.new
  end
end