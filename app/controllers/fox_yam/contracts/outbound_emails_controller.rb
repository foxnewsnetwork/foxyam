class FoxYam::Contracts::OutboundEmailsController < FoxYam::BaseController
  expose(:interactor) { _interactor }

  def new; end
  def create

  end
  private
  def _interactor
    @interactor ||= FoxYam::Contracts::OutboundEmails::Interactor.new _contract
  end
  def _contract
    @contract ||= Gtps::Contract.find params[:contract_id]
  end
end