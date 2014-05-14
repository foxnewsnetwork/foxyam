class FoxYam::Offers::NevermindsController < FoxYam::Offers::FinalizesController
  def create
    _unfinalize_offer!
    _get_out_of_here!
  end
  private
  def _unfinalize_offer! 
    @result = _creative_interactor.nevermind!
  end
  def _finalize_params
    params.require(:neverminds).permit(*FoxYam::Offers::Finalizes::Interactor::Fields)
  end
  def _get_out_of_here! 
    return redirect_to offer_path(_offer) if @result.success?
    render :new
  end
end