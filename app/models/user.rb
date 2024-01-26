# frozen_string_literal: true

# User model to store user data
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :posts, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy

  # Relationships for friend requests
  # Users who follow this user
  has_many :follower_relationships, foreign_key: :followed_id, class_name: 'Friendship', dependent: :destroy
  has_many :followers, through: :follower_relationships, source: :follower

  # Users this user follows
  has_many :following_relationships, foreign_key: :follower_id, class_name: 'Friendship', dependent: :destroy
  has_many :following, through: :following_relationships, source: :followed

  # Attachments
  has_one_attached :profile_picture
  has_one_attached :banner_image

  # Notifications
  has_many :notifications, dependent: :destroy

  # Validations
  validates :username, presence: false, uniqueness: { case_sensitive: false }
end
