# frozen_string_literal: true

# This is the Like model. It stores likes on posts by users.
class Like < ApplicationRecord
  # Associations
  belongs_to :user
  belongs_to :likeable, polymorphic: true

  # Validations
  validates :user_id, presence: true
  validates :likeable_id, presence: true, uniqueness: { scope: %i[user_id likeable_type] }
end
