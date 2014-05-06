class FoxYam::Negotiations::RevivesController < FoxYam::Negotiations::DeathsController
  def create
    _grant_life!
    _setup_flash!
    _get_out_of_here!
  end

  private
  def _grant_life! 
    @result = _negotiation.update dead_at: nil
  end
  def _setup_flash!
    flash[:success] = t(:successfully_revived) if @result.present?
    flash[:error] = t(:unable_to_revive) if @result.blank?
  end
end