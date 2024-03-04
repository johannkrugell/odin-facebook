# frozen_string_literal: true

# Post model to store user posts
class Post < ApplicationRecord
  # Associations
  belongs_to :user
  has_many :likes, as: :likeable, dependent: :destroy
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :photos, dependent: :destroy

end
