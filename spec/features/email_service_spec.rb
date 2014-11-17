require_relative 'feature_spec_helper'
require_relative '../../app/services/email'
require_relative '../../app/services/signup_message'

RSpec.describe SignupMessage, feature: true do

  describe "#deliver" do
    it "send an email ok" do
      FakeUser = Struct.new(:email)
      fakeuser = FakeUser.new("groot@marvel.com")

      SignupMessage.new(
        email: fakeuser.email,
        intercept_emails: true
      ).deliver
      # Integration test. Go look in mailcatcher to make sure you're happy with this
    end
  end
end