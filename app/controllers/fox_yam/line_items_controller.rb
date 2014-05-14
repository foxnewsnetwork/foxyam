class FoxYam::LineItemsController < FoxYam::BaseController
  before_filter :_reject_anonymous_users,
    :_select_correct_users
  def destroy
    _destroy_line_item!
    _get_out_of_here!
  end

  private
  def _correct_merchant
    _offer.negotiation.try :merchant
  end
  def _destroy_line_item!
    @result = _line_item.destroy
  end

  def _get_out_of_here!
    redirect_to offer_line_items_path(_offer)
  end

  def _offer
    _line_item.offer
  end

  def _line_item
    @line_item ||= FoxYam::LineItem.find params[:id]
  end
end