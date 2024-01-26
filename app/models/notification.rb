# frozen_string_literal: true

# Notifications for users
class Notification < ApplicationRecord
  # associations, validations, etc.
  belongs_to :user

  # Set default value for 'read' attribute
  after_initialize :set_defaults, unless: :persisted?

  private

  def set_defaults
    self.read ||= false
  end
end
