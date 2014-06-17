class Apiv1::PicturesController < Apiv1::BaseController

  def create
    _creative_interactor.pictures!
    render json: { picture: _conversation_attributes }
  end

  private
  def _conversation_attributes
    _presenter.attributes
  end
  def _presenter
    @presenter ||= Apiv1::Pictures::Presenter.new _interactor
  end
  def _picture_params
    params.require(:picture)[:file]
  end
  def _interactor
    @interactor ||= FoxYam::Listings::Pictures::Interactor.new _conversation
  end
  def _creative_interactor
    _interactor.tap do |i|
      i.attributes = { pictures: [_picture_params] }
    end
  end
  def _conversation
    @conversation ||= FoxYam::Conversation.find params[:picture][:conversation_id]
  end
end