class Admin < Sequel::Model
  plugin :validation_helpers

  include BCrypt

  def initialize(params = {})
    @nome     = params.fetch(:nome) { "Fernanda" }
    @email    = params[:email]
    @password = params[:password]
    generate_hash

    super(values)
  end

  def validate
    super
    validates_presence [:nome, :email, :password_salt, :password_hash]
  end

  def authenticate(password)
    self[:password_hash] == Engine.hash_secret(password, self[:password_salt])
  end

  private

  def generate_hash
    @password_salt = Engine.generate_salt
    @password_hash = Engine.hash_secret(@password, @password_salt)
  end

  def values
    {
      nome: @nome,
      email: @email,
      password_salt: @password_salt,
      password_hash: @password_hash
    }
  end
end
