# frozen_string_literal: true

# User model to store user data
class User < ApplicationRecord
  before_validation :ensure_username_uniqueness, on: :create
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:github, :google_oauth2]
  has_many :posts, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :photos, through: :posts
  
  def self.from_omniauth(auth)
    Rails.logger.debug "Omniauth auth hash: #{auth.inspect}"
    # Find an existing user by provider and uid first
    user = User.find_by(provider: auth[:provider], uid: auth[:uid])
  
    # If user doesn't exist with provider and uid, find by email or create new
    user ||= User.where(email: auth[:email]).first_or_initialize
  
    # Set provider and uid for new users
    user.provider ||= auth[:provider]
    user.uid ||= auth[:uid]
  
    # Set additional fields
    user.email = auth.info.email if user.email.blank?
    user.username = auth.dig(:info, :name) if auth.dig(:info, :name) # or username depending on the provider's data
    # user.remote_profile_picture_url = auth.info.image # This assumes you have a method to save images from a URL
    user.password = Devise.friendly_token[0, 20] if user.encrypted_password.blank?
    user.avatar_url = auth.dig(:info, :image) if auth.dig(:info, :image).present?
   
    # Save the user if it's a new record or has been changed
    user.save if user.new_record? || user.changed?
  
    user
  end
  
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
  validates :username, presence: true, uniqueness: { case_sensitive: false }

end

private

  def ensure_username_uniqueness
    if self.username.blank?
      self.username = generate_unique_username(self.email.split('@').first)
    end
  end

  def generate_unique_username(base_username)
    new_username = base_username
    num = 2
    while User.exists?(username: new_username)
      new_username = "#{base_username}_#{num}"
      num += 1
    end
    new_username
  end