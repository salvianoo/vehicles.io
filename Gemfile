source "https://rubygems.org"

ruby "2.1.4"

gem 'sinatra', '~> 1.4.4', require: 'sinatra/base'
gem 'sinatra-contrib'
gem 'sequel'
gem 'pg'
gem 'bcrypt'
gem 'dotenv'
gem 'bugsnag'

# Pony must not be required
# http://stackoverflow.com/questions/14824179/typeerror-cannot-visit-mailmultibytechars
gem 'pony', '~> 1.6', require: false

gem 'puma'
gem 'rack-flash3'
gem 'faker'

group :test, :development do
  gem 'rspec'
  gem 'rack-test'
  gem 'database_cleaner'
  gem 'mailcatcher'
end
