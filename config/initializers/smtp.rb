ActionMailer::Base.smtp_settings = {
  address: "smtp.sparkpostmail.com",
  port: 587,
  domain: 'sparkpostmail.com',
  user_name: ENV['SPARKPOST_USERNAME'],
  password: ENV['SPARKPOST_PASSWORD'],
  authentication: :login,
  enable_starttls_auto: true
}
