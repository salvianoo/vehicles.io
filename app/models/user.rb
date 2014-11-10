class User < Sequel::Model
  plugin :validation_helpers

  include BCrypt

  attr_accessor :email, :password
  # attr_reader :password_salt, :password_hash

  def validate
    super
    validates_presence [:email, :password]
  end

  def initialize(user_params = {})
    @email    = user_params[:email]
    @password = user_params[:password]

    generate_hash
  end

  def self.authenticate(user, password)
    user[:password_hash] == Engine.hash_secret(password, user[:password_salt])
  end

  def save
    DB[:users]
    .insert(email: email,
            password_salt: @password_salt,
            password_hash: @password_hash)
  end

  private

  def generate_hash
    @password_salt = Engine.generate_salt
    @password_hash = Engine.hash_secret(password, @password_salt)
  end
end
