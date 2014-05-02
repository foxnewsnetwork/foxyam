class FoxYam::Sells::Presenter < FoxYam::Buys::Presenter
  private
  def _negotiation_scope_core
    FoxYam::Negotiation.unfinalized.alive.completed.buy_type
  end
end