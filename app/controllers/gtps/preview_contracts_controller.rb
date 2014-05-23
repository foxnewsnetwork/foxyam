class Gtps::PreviewContractsController < FoxYam::BaseController
  expose(:presenter) { _presenter }
  def show; end

  private
  def _presenter
    @presenter ||= Gtps::PreviewContracts::Presenter.new _contract
  end
  def _contract
    @contract ||= Gtps::Contract.find params[:id]
  end
end