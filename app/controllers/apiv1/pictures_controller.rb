class Apiv1::PicturesController < Apiv1::BaseController

  def create
    # Not implemented
  end

  private
  def _picture_params
    params.require(:pictures)[:pictures]
  end
  def _interactor
    @interactor ||= FoxYam::Listings::Pictures::Interactor.new _conversation
  end
  def _creative_interactor
    _interactor.tap do |i|
      i.attributes = { pictures: _picture_params }
    end
  end
  def _conversation
    @conversation ||= _negotiation.conversations.first
  end
  def _negotiation
    @negotiation ||= FoxYam::Negotiation.find params[:listing_id]
  end
end