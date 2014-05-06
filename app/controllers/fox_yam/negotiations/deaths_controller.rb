class FoxYam::Negotiations::DeathsController < FoxYam::BaseController
  def create
    _deal_death!
    _setup_flash!
    _get_out_of_here!
  end

  private
  def _deal_death! 
    @result = _negotiation.update dead_at: DateTime.now
  end
  def _setup_flash!
    flash[:success] = t(:successfully_marked_dead) if @result.present?
    flash[:error] = t(:unable_to_mark_dead) if @result.blank?
  end
  def _get_out_of_here! 
    redirect_to negotiation_path(_negotiation, s: 'admin')
  end
  def _negotiation
    @negotiation ||= FoxYam::Negotiation.find params[:negotiation_id]
  end
end