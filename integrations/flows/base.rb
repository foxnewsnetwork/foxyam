class Integrations::Flows::Base
  class << self
    def run(u=nil)
      new(u).run
    end
  end
  attr_writer :views, :upstreams, :fixtures
  attr_reader :user
  def initialize(raw_user=nil)
    @raw_user = raw_user
    setup_fixtures if responds_to? :setup_fixtures
    setup_views if responds_to? :setup_views
    setup_upstreams if responds_to? :setup_upstreams
  end

  def views
    @views ||= []
  end

  def upstreams
    @upstreams ||= []
  end

  def fixtures
    @fixtures ||= ActiveSupport::OrderedHash.new
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

  def _raw_user
    @raw_user ||= Integrations::Sessions::UserBase.new
  end

  def _stateless_user
    @stateless_user ||= 
  end

  def _user
    @user ||= upstreams.inject(_raw_user) do |user, upstream|
      upstream.run(user).user
    end
  end

end