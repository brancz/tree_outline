$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

unless ENV['CI']
  require 'simplecov'
  SimpleCov.start
end

if ENV['CI']
  require 'codeclimate-test-reporter'
  CodeClimate::TestReporter.start
end

require 'tree_outline'
