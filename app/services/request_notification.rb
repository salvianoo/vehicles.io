require 'erb'

class RequestNotification

  def initialize(opts = {})
    @request          = opts.fetch(:request)
    @intercept_emails = opts.fetch(:intercept_emails) { development? }
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
    'request_notification'
  end

  def template(name)
    File.read File.join('app', 'services', 'email', "#{name}.erb")
  end

  def to
    admin.email
  end

  def from_email
    'vehicles.io <salviano.lfg@gmail.com>'
  end

  def subject
    "Nova Requisição de Veículo <vehicles.io>"
  end

  def admin
    @admin = Admin.last
  end

  def intercept_emails?
    @intercept_emails
  end

  def development?
    ENV['RACK_ENV'] == 'development'
  end
end
