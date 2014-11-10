require 'bcrypt'
require 'faker'

require_relative "../config/database"
require_relative "../app/models/user"

def create_fake_user
  user_params = {
    email:    Faker::Internet.email,
    password: Faker::Internet.password(8, 16)
  }
  User.new(user_params).save
end

def seed_users(number_of_users)
  number_of_users.times { create_fake_user }
end
