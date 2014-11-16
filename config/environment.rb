# Set up gems listed in the Gemfile
# See: http://gembundler.com/bundler_setup.html
#      http://stackoverflow.com/questions/7243486/why-do-you-need-require-bundler-setup
ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../../Gemfile', __FILE__)

require 'bundler/setup'

# Require gems we care about
# require 'rubygems'

require 'bcrypt'
require 'sinatra'
require 'sinatra/reloader'
require 'bugsnag'
require 'pathname'
require 'rack-flash'

# Some helper constants for path-centric logic
APP_ROOT = Pathname.new(File.expand_path('../../', __FILE__))

configure do
  # set :root, APP_ROOT.to_path
  set :root, APP_ROOT

  if ENV.fetch('RACK_ENV') == "development"
    register Sinatra::Reloader
  end

  enable :sessions
  use Rack::Flash

  use Bugsnag::Rack
  enable :raise_errors

  set :session_secret, ENV['SESSION_SECRET'] || 'this is a secret shhhhh'

  set :views, File.join(APP_ROOT, 'app', 'views')
end
