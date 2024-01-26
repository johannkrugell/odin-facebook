# frozen_string_literal: true

module Users
  class RegistrationsController < Devise::RegistrationsController
    def create
      super do |user|
        UserMailer.welcome_email(user).deliver_later if user.persisted? && user.valid?
      end
    end
  end
end
