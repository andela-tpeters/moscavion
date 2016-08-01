require 'coveralls'
require 'simplecov'
Coveralls.wear!

RSpec.configure do |config|

  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end
end

SimpleCov.formatter = Coveralls::SimpleCov::Formatter
SimpleCov.start do
  add_filter "/spec/"
  add_filter "/vendor/" # Ignores any file containing "/vendor/" in its path.
  add_filter "/Gemfile.lock" # Ignores a specific file.
end
