# frozen_string_literal: true

# User model to store user data
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :posts
  has_many :likes
  
  # Relationships for friend requests
  # Users who follow this user
  has_many :follower_relationships, foreign_key: :followed_id, class_name: 'Friendship'
  has_many :followers, through: :follower_relationships, source: :follower

  # Users this user follows
  has_many :following_relationships, foreign_key: :follower_id, class_name: 'Friendship'
  has_many :following, through: :following_relationships, source: :followed
end
