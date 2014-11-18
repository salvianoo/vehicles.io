## README

### 1. You will need install rvm and ruby 2.1.4:

    $ \curl -sSL https://get.rvm.io | bash -s stable

    $ rvm install 2.1.4

### 2. You will need Postgresql:

- [Download Postgres for OSX](http://postgresapp.com/)

### 3. Create the databases:

    $ createdb vehicles_development -U your_username
    $ createdb vehicles_test -U your_username

### 4. Then install dependencies with bundler:

    $ bundle install

### 5. Run the migrations:

    $ sequel -m db/migrations postgres://your_username:@localhost/vehicles_development
    $ sequel -m db/migrations postgres://your_username:@localhost/vehicles_test

### 6. Run the tests:

    $ bundle exec rspec spec

### 7. How to setup this project on Heroku:

    $ heroku config:add SESSION_SECRET=longest_secret_key

    $ git push heroku master

    $ heroku run
