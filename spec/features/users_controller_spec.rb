require_relative 'feature_spec_helper'

RSpec.describe "Users controller", feature: true do
  let(:user_hash) do
    {
      :email    => "ted@google.com",
      :password => "12345678"
    }
  end

  it "GET /login response Ok" do
    get '/login'

    expect(last_response).to be_ok
  end

  it "POST /singup" do
    post '/signup', user_hash
  end

  it "GET /signup response Ok" do
    get '/signup'

    expect(last_response).to be_ok
  end

  it "POST /login response Ok" do
    post '/login', user_hash
  end
end
