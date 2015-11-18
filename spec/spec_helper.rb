require "codeclimate-test-reporter"
CodeClimate::TestReporter.start

$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'pundit_namespaces'

Dir[File.expand_path('../support/**/*.rb', __FILE__)].each { |f| require f }
