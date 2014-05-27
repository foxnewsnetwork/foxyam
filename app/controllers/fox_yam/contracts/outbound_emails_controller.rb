class FoxYam::Contracts::OutboundEmailsController < FoxYam::BaseController
  expose(:interactor) { _interactor }

  def new; end
  def create
    _queue_outbound_email!
    _get_out_of_here!
  end
  private
  def _queue_outbound_email!
    @result = _creative_interactor.queue_outbound_email!
  end
  def _creative_interactor
    _interactor.tap do |i|
      i.attributes = _outbound_email_params
    end
  end
  def _outbound_email_params
    params.require(:outbound_emails).permit *FoxYam::Contracts::OutboundEmails::Interactor::Fields
  end
  def _get_out_of_here!
    redirect_to escrow_progression_path(_contract) if @result.success?
    render :new
  end
  def _interactor
    @interactor ||= FoxYam::Contracts::OutboundEmails::Interactor.new _contract
  end
  def _contract
    @contract ||= Gtps::Contract.find params[:contract_id]
  end
end