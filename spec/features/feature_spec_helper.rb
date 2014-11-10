# ENV['RACK_ENV'] = 'test'

require_relative "../../config/database"
require_relative "../../app/controllers/users"

require "rack/test"

Dir[APP_ROOT.join('app', 'models', '*.rb')].each do |model_file|
  require model_file
end

module RackSpecHelpers
  include Rack::Test::Methods

  attr_accessor :app
end

module DbSpecHelpers
  attr_accessor :db
end

RSpec.configure do |c|
  c.include RackSpecHelpers, feature: true
  c.before feature: true do
    self.app = Sinatra::Application
  end

  c.before :suite do
    DatabaseCleaner[:sequel, {connection: ::DB}].strategy = :transaction
    DatabaseCleaner[:sequel, {connection: ::DB}].clean_with(:truncation)
  end

  c.include DbSpecHelpers, feature: true
  c.before feature: true do
    self.db = ::DB
    DatabaseCleaner[:sequel, {connection: ::DB}].start
  end

  c.after feature: true do
    DatabaseCleaner[:sequel, {connection: ::DB}].clean
  end
end
