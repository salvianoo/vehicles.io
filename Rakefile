require_relative "db/seed.rb"

namespace :db do
  require 'sequel'
  require 'pg'

  namespace :migrate do
    Sequel.extension :migration

    DB = Sequel.connect(ENV['DATABASE_URL'])

    desc "Perform migration up to latest migration available"
    task :up do
      Sequel::Migrator.run(DB, "db/migrations")
      puts "<= db:migrate:up executed"
    end
  end

  task :seed do
    # ENV['RACK_ENV'] = 'test'

    seed_users 20
  end
end
