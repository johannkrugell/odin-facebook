# frozen_string_literal: true

# Post model to store user posts
class Post < ApplicationRecord
  belongs_to :user
  has_many :comments
  has_many :likes
end
