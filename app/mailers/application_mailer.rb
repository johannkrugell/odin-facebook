# frozen_string_literal: true

# Mailer class for sending emails
class ApplicationMailer < ActionMailer::Base
  default from: 'from@example.com'
  layout 'mailer'
end
