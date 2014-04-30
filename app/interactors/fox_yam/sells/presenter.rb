class FoxYam::Sells::Presenter < FoxYam::Buys::Presenter
  private
  def _unfinalized_public_negotiations
    @unfinalized_public_negotiations ||= FoxYam::Negotiation.publicly_available.unfinalized.alive.completed.sale_type
  end
end