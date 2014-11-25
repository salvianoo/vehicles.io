class User < Sequel::Model
  plugin :validation_helpers

  include BCrypt

  # attr_reader email: :email

  def initialize(params = {})
    @email    = params[:email]
    @password = params[:password]
    generate_hash

    super(values)
  end

  def validate
    super
    validates_presence [:email, :password_salt, :password_hash]
  end

  def authenticate(password)
    self[:password_hash] == Engine.hash_secret(password, self[:password_salt])
  end

  def get_email
    @email
  end

  private

  def generate_hash
    @password_salt = Engine.generate_salt
    @password_hash = Engine.hash_secret(@password, @password_salt)
  end

  def values
    {
      email: @email,
      password_salt: @password_salt,
      password_hash: @password_hash
    }
  end
end
