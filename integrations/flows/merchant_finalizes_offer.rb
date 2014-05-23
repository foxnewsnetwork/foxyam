class Integrations::Flows::MerchantFinalizesOffer < Integrations::Flows::Base
  

  def setup_views
    self.views.push 'Welcome::Index#click_buy_materials_button'
  end

  def setup_fixtures
    self.fixtures[:user] = Integrations::Fixtures::UserMerchant
    self.fixtures[:negotiation] = Integrations::Fixtures::Negotiation.given fixtures[:user]
    self.fixtures[:offer] = Integrations::Fixtures::Offer.given fixtures[:negotiation]
  end

  def setup_upstreams
    self.upstreams.push Integrations::Flows::AnonymousUserSignsIn
  end
end