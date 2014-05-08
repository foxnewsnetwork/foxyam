class Integrations::Flows::Sanity
  class << self
    def run
      new.run
    end
  end
  attr_accessor :views
  def initialize
    @views = []
    @views.push 'Welcome::Index#click_buy_materials_button'
  end

  def run
    views.reduce(_user) do |user, view|
      _view_class(view).new(user).tap { |v| v.send(_view_action view) }.user
    end
  end

  private
  def _view_class(view_string)
    Integrations::Views.const_get(view_string.split('#').first)
  end

  def _view_action(view_string)
    view_string.split('#').last
  end

  def _user
    Integrations::Sessions::UserBase.new
  end
end