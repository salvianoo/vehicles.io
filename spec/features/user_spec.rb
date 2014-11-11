require_relative 'feature_spec_helper'
require 'database_cleaner'

RSpec.describe User, feature: true do
  let(:user_hash) do
    {
      :email    => "ted@google.com",
      :password => "12345678"
    }
  end

  before :each do
    User.create(user_hash)
  end

  describe ".authenticate" do
    it "should be true for a valid user" do
      user = User[:email => user_hash[:email]]
      password = user_hash[:password]

      expect(user.authenticate(password)).to be true
    end

    it "should be false for an invalid user" do
      user = User[:email => user_hash[:email]]
      passsword_invalid = "senha invalida"

      expect(user.authenticate(passsword_invalid)).to be false
    end
  end

  describe "#save" do
    it "should insert a new user into database" do
      new_user = User.create(user_hash)

      user = User[:id => new_user[:id]]

      expect(new_user[:id]).to eq(user[:id])
    end
  end

  describe "Users table" do
    it "should be one single user saved" do
      expect(db[:users].count).to eq(1)
    end
  end

end
