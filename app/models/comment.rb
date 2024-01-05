# frozen_string_literal: true

# Comment model to store comments on posts by users
class Comment < ApplicationRecord
  # Associations
  belongs_to :user
  belongs_to :commentable, polymorphic: true
  has_many :likes, as: :likeable

  # Validations
  validates :user_id, presence: true
  validates :text, presence: true, length: { maximum: 1000 }
end
