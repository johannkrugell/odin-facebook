# frosen_string_literal: true

# Photo model
class Photo < ApplicationRecord
  # Associations
  belongs_to :user # If you want to track which user uploaded the photo
  belongs_to :post, optional: true
  has_one_attached :image
  has_many :likes, as: :likeable
  has_many :comments, as: :commentable
  
  # Validations
  # Add any validations you need for the Photo model

end
