require 'erb'

class SignupMessage

  def initialize(user_email)
    @email = user_email
  end

  def deliver
    Email.new(
      to: to,
      from: from_email,
      subject: subject,
      body: body
    ).ship
  end

  def body
    ERB.new(template(template_name)).result binding
  end

  def template_name
    "signup_message"
  end

  def template(name)
    File.read File.join('app', 'services', 'email', "#{name}.erb")
  end

  def to
    @email
  end

  def from_email
    'vehicles.io <salviano.lfg@gmail.com>'
  end

  def subject
    'Seja bem vindo'
  end
end
