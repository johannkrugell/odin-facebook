# frozen_string_literal: true

# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#

# Create users for testing

#  Delete all users before seeding
# User.delete_all

# Array of user data to seed for the development environment
if Rails.env.development?
  user_data = [
    { email: 'user1@example.com', password: 'password', password_confirmation: 'password' },
    { email: 'user2@example.com', password: 'password', password_confirmation: 'password' }
    # Add as many users as you want
  ]

  # Creating users
  user_data.each do |data|
    User.create!(data)
  end
end
