class Conversations::PicturesController < ApplicationController
  expose(:interactor) { _interactor }
  def new; end

  def create
    _create_picture_tag!
    _get_out_of_here!
  end
  private
  def _interactor
    @interactor ||= Coversations::Pictures::Interactor.new _conversation
  end

  def _creative_interactor
    _interactor.tap do |i|
      i.attributes = _pictures_params
    end
  end

  def _create_picture_tag!
    @result = _creative_interactor.picture_tag!
  end

  def _get_out_of_here!
    return redirect_to negotiation_path(interactor.negotiation) if @result.success?
    render :new
  end

  def _pictures_params
    params.require(:pictures).permit(*Conversations::Pictures::Interactor::Fields)
  end
end