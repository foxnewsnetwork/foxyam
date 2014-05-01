class FoxYam::Negotiations::PublicizesController < FoxYam::BaseController

  def create
    _alter_publicity_status!
    _get_out_of_here!
  end

  private
  def _alter_publicity_status!
    @result = _negotiation.update public_at: DateTime.now
  end
  def _get_out_of_here!
    redirect_to negotiation_path(_negotiation)
  end
  def _negotiation
    @negotiation ||= FoxYam::Negotiation.find params[:negotiation_id]
  end
end