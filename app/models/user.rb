class User < Sequel::Model
  plugin :validation_helpers

  include BCrypt

  # attr_accessor :email, :password
  # attr_reader :password_salt, :password_hash

  def validate
    super
    validates_presence [:email, :password_salt, :password_hash]
  end

  def authenticate(password)
    self[:password_hash] == Engine.hash_secret(password, self[:password_salt])
  end

  def self.create(values = {}, &block)
    email    = values[:email]
    password = values[:password]

    password_salt = Engine.generate_salt
    password_hash = Engine.hash_secret(password, password_salt)

    super(email: email,
          password_salt: password_salt,
          password_hash: password_hash)
  end
end
