$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'qualtrics'
require 'webmock/rspec'

Dir['./spec/support/**/*.rb'].each do |file|
  require file
end

RSpec.configure do |config|
  config.include RequestStubHelpers
end
