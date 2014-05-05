class FoxYam::SellConversations::TagsController < Conversations::TagsController

  private
  def _interactor
    @interactor ||= FoxYam::SellConversations::Tags::Interactor.new _conversation
  end

  def _conversation
    @conversation ||= FoxYam::Conversation.find params[:sell_conversation_id]
  end

  def _get_out_of_here!
    return redirect_to sell_conversation_pictures_path _conversation if @result.success?
    render :index
  end
end