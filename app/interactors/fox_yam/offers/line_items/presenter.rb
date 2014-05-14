class FoxYam::Offers::LineItems::Presenter < FoxYam::Offers::Finalizes::Presenter
  def line_items
    offer.line_items.map { |li| FoxYam::Offers::LineItems::LineItemPresenter.new li }
  end
end