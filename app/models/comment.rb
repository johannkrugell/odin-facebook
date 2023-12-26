# frozen_string_literal: true

# Comment model to store comments on posts by users
class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post

  # Validations
  validates :user_id, presence: true
  validates :post_id, presence: true
  validates :text, presence: true, length: { maximum: 1000 }
end
