module FoxYam
  class << self
    def r
      @_route_debugger ||= FoxYam::RouteDebugger.new
    end
  end

  class RouteDebugger
    include Rails.application.routes.url_helpers
  end
end