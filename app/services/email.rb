require 'pony'

class Email
  def initialize(options)
    @to               = options.fetch(:to)
    @from             = options.fetch(:from)
    @subject          = options.fetch(:subject)
    @body             = options.fetch(:body)
    @html_body        = options.fetch(:html_body) { false }
    @intercept_emails = options.fetch(:intercept_emails) { false }
  end

  def ship
    Pony.mail(params)
  end

  private

  def params
    if @intercept_emails
      options_for_mailcatcher
    else
      options_for_humans
    end
  end

  def base_options
    options = {
      to: @to,
      from: @from,
      subject: @subject,
      body: @body
    }

    if @html_body
      options.merge(html_body: @html_body)
    else
      options
    end
  end

  def options_for_mailcatcher
    base_options.merge(
      via: :smtp,
      via_options: {
        address: "localhost",
        port: 1025
      }
    )
  end

  def options_for_humans
    base_options.merge(
      via: :smtp,
      via_options: {
        address: 'smtp.sendgrid.net',
        port: '587',
        domain: 'heroku.com',
        user_name: ENV.fetch('SENDGRID_USERNAME'),
        password: ENV.fetch('SENDGRID_PASSWORD'),
        authentication: :plain,
        enable_starttls_auto: true
      }
    )
  end
end
