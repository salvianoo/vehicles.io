require_relative "db/seed.rb"

namespace :db do

  namespace :migrate do
    Sequel.extension :migration

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
