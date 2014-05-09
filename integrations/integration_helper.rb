ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'capybara'
require 'rspec'
require 'rspec/autorun'

module Integrations
  module Flows
    Dir[File.join(__dir__, 'flows', '**', '*.rb')].each { |f| require f }
  end
  module Sessions
    Dir[File.join(__dir__, 'sessions', '**', '*.rb')].each { |f| require f }
  end
  module Views
    require File.join(__dir__, 'views', 'base.rb')
    module Welcome
      Dir[File.join(__dir__, 'views', 'welcome', '*.rb')].each { |f| require f }
    end
  end
end