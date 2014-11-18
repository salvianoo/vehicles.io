require_relative 'feature_spec_helper'
require_relative '../../app/services/email'
require_relative '../../app/services/signup_message'

RSpec.describe SignupMessage, feature: true do

  describe "#deliver" do
    it "send email with a signup notification using mailcatcher" do
      FakeUser = Struct.new(:email)
      fakeuser = FakeUser.new("groot@marvel.com")

      send_email_with_mailcatcher = -> (option = true) do
        SignupMessage.new(
          email: fakeuser.email,
          intercept_emails: option
        ).deliver
      end

      if ENV['RACK_ENV'] == 'development'
        send_email_with_mailcatcher.call
      end
      # Integration test. Go look in mailcatcher to make sure you're happy with this
    end
  end
end
