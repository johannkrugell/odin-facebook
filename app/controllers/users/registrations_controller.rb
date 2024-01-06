class Users::RegistrationsController < Devise::RegistrationsController
  def create
    super do |user|
      if user.persisted?
        UserMailer.welcome_email(user).deliver_later if user.valid?
      end
    end
  end
end
