# frozen_string_literal: true

class UserMailer < ApplicationMailer
  helper :application # gives access to all helpers defined within `application_helper`.
  include Devise::Controllers::UrlHelpers # Optional, for Devise-specific URL helpers like `confirmation_url`.

  # Update the default template path to point to your custom mailer views
  default template_path: 'user_mailer'

  default from: 'from@example.com'

  def welcome_email(user)
    @user = user
    mail(to: @user.email, subject: 'Welcome to Our Application!')
  end
end
