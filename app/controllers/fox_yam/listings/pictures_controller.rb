class FoxYam::Listings::PicturesController < FoxYam::BaseController
  expose(:interactor) { _interactor }
  def new; end
  def create
    _make_pictures!
    _get_out_of_here!
  end

  private
  def _make_pictures!
    @result = _creative_interactor.pictures!
  end
  def _creative_interactor
    _interactor.tap do |i|
      i.attributes = { pictures: _picture_params }
    end
  end
  def _picture_params
    params.require(:pictures)[:pictures]
  end
  def _interactor
    @interactor ||= FoxYam::Listings::Pictures::Interactor.new _conversation
  end
  def _conversation
    @conversation ||= FoxYam::Conversation.find params[:listing_id]
  end
  def _get_out_of_here!
    return redirect_to negotiation_path(interactor.negotiation) if @result.success?
    render :new
  end
end