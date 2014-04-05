class Conversations::TagsController < ApplicationController
  expose(:interactor) { _interactor }
  def index; end

  def create
    _create_tag!
    _get_out_of_here!
  end

  private
  def _interactor
    @interactor ||= Conversations::Tags::Interactor.new _conversation
  end

  def _conversation
    @conversation ||= Conversation.find params[:conversation_id]
  end

  def _create_tag!
    @result ||= _creative_interactor.tag!
  end

  def _get_out_of_here!
    return redirect_to conversation_tags_path _conversation if @result.success?
    render :index
  end

  def _creative_interactor
    _interactor.tap do |i|
      i.attributes = _tag_params
    end
  end

  def _tag_params
    params.require(:tags).permit *Conversations::Tags::Interactor::Fields
  end

end