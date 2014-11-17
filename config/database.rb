require 'pg'
require 'sequel'
require 'dotenv'

Dotenv.load

environment = ENV.fetch('RACK_ENV') { 'development' }

connection_string = ENV["DATABASE_URL"] ||
                    ENV["DATABASE_URL_#{environment.upcase}"] ||
                    ENV["DATABASE_URL_CI_TEST"]

DB = Sequel.connect(connection_string)
