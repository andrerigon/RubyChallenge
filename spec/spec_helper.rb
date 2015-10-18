require 'simplecov'
require 'rack/test'

require File.expand_path '../../lib/app.rb', __FILE__
require File.expand_path '../../lib/api_request.rb', __FILE__
require File.expand_path '../../lib/api_response.rb', __FILE__


SimpleCov.start

module RSpecMixin
  include Rack::Test::Methods
  def app() App end
end

RSpec.configure do |config|

  config.include RSpecMixin

  config.include Rack::Test::Methods

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.filter_run :focus
  config.run_all_when_everything_filtered = true

  config.disable_monkey_patching!

  config.warnings = true

  if config.files_to_run.one?
    config.default_formatter = 'doc'
  end
end
