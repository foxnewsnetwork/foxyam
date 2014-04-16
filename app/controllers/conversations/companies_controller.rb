class Conversations::CompaniesController < ApplicationController
  expose(:interactor) { _interactor }
  def new; end

  def create
    _document_conversation!
    _get_out_of_here!
  end

  private
  def _document_conversation!
    @result ||= _creative_interactor.conversation!
  end

  def _creative_interactor
    _interactor.tap do |i|
      i.attributes = _company_params
    end
  end

  def _company_params
    params.require(:companies).permit *Conversations::Companies::Interactor::Fields
  end

  def _get_out_of_here!
    return redirect_to conversation_tags_path _conversation if @result.success?
    render :new
  end

  def _interactor
    @interactor ||= Conversations::Companies::Interactor.new _conversation
  end

  def _conversation
    @conversation ||= FoxYam::Conversation.find params[:conversation_id]
  end

end