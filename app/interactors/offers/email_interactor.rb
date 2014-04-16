class Offers::EmailInteractor

  def initialize(email)
    @email = email
  end

  def update!
    
  end

  private

  def _conversation
    _negotiation.offers
  end

  def _negotiation
    FoxYam::Negotiation.find _negotiation_id
  end

  def _negotiation_id
    @email.negotiation_id
  end
end