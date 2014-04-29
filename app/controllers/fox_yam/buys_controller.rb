class FoxYam::BuysController < FoxYam::BaseController
  expose(:presenter) { _presenter }
  def index; end

  private
  def _presenter
    @presenter ||= FoxYam::Buys::Presenter.new
  end
end