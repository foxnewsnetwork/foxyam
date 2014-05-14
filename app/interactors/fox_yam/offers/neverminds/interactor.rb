class FoxYam::Offers::Neverminds::Interactor < FoxYam::Offers::Finalizes::Interactor
  def nevermind!
    FoxYam::ResultBase.new _unfinalize_merchant_offer
  end
  private
  def _unfinalize_merchant_offer
    offer.update merchant_finalized_at: nil
  end
end