require 'erb'

class UserNotification

  def initialize(options)
    @email            = options.fetch(:email)
    @token            = options.fetch(:token)
    @intercept_emails = options.fetch(:intercept_emails) { development? }
  end

  def deliver
    Email.new(
      to: to,
      from: from_email,
      subject: subject,
      body: body,
      intercept_emails: intercept_emails?
    ).ship
  end

  def body
    ERB.new(template(template_name)).result binding
  end

  def template_name
    'user_notification'
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
    'Aprovação da requisição de veículo'
  end

  def intercept_emails?
    @intercept_emails
  end

  def development?
    ENV['RACK_ENV'] == 'development'
  end
end
