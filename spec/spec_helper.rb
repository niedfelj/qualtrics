$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
require "qualtrics"
require "webmock/rspec"
require "simplecov"

SimpleCov.start do
  add_group "Lib", "/lib/"

  add_filter "/bin/"
  add_filter "/spec/"
end

Dir["./spec/support/**/*.rb"].each do |file|
  require file
end

RSpec.configure do |config|
  config.include RequestStubHelpers
end
