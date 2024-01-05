# frozen_string_literal: true

# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

# Create users for testing

# Delete all users before seeding
# Find all users where the user_id is not 1
# Delete all posts where the user_id is not 1
Friendship.destroy_all
Post.destroy_all
User.destroy_all
Comment.destroy_all
Like.destroy_all
Notification.destroy_all

if Rails.env.development?
  # Constants
  USER_COUNT = 20  # Adjust as needed
  FRIENDSHIPS_PER_USER = 2  # Adjust as needed
  POSTS_PER_USER = 2  # Number of posts per user+

  # Creating Users
  USER_COUNT.times do
    User.create!(
      email: Faker::Internet.unique.email,
      username: Faker::Internet.unique.username,
      password: 'password',  # Use a simple password for seed data
      password_confirmation: 'password'
    )
  end

  # Creating Friendships
  User.all.each do |user|
    FRIENDSHIPS_PER_USER.times do
      friend = User.where.not(id: user.id).sample
      user.following_relationships.create(followed_id: friend.id, status: 'approved')
      # Set the friendship status as 'approved'
    end
  end

  # Creating posts
  User.find_each do |user|
    POSTS_PER_USER.times do
      user.posts.create!(
        text: Faker::Hipster.sentence(word_count: 7),  # Adjust the content as needed
        # Add other post fields if necessary
      )
    end
  end
  
  puts "Seed data created successfully!"

end