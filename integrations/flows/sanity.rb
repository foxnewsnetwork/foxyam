class Integrations::Flows::Sanity < Integrations::Flows::Base
  def initialize
    setup_views
  end

  def setup_views
    self.views.push 'Welcome::Index#click_buy_materials_button'
  end
end