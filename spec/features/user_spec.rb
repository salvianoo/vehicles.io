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
    User.new(user_hash).save
  end

  describe ".authenticate" do
    it "should be true for a valid user" do
      user = db[:users][email: user_hash[:email]]
      password = user_hash[:password]

      expect(User.authenticate(user, password)).to be true
    end

    it "should be false for an invalid user" do
      user = db[:users][email: user_hash[:email]]
      passsword_invalid = "senha invalida"

      expect(User.authenticate(user, passsword_invalid)).to be false
    end
  end

  describe "#save" do
    it "should insert a new user into database" do
      user_id = User.new(user_hash).save
      user = db[:users][id: user_id]

      expect(user[:id]).to eq(user_id)
    end
  end

  describe "Users table" do
    it "should be one single user saved" do
      expect(db[:users].count).to eq(1)
    end
  end

end
