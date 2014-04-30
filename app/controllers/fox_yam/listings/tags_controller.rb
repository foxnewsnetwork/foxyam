class FoxYam::Listings::TagsController < Conversations::TagsController
  private
  def _conversation
    @conversation ||= FoxYam::Conversation.find params[:listing_id]
  end
  def _get_out_of_here!
    return redirect_to listing_tags_path(interactor.conversation) if @result.success?
    render :index
  end
end