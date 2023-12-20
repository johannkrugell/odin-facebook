# frozen_string_literal: true

# This migration creates the 'friendships' table in the database.
# The table has columns for 'follower_id', 'followed_id', and 'status'.
# It also includes timestamps for created_at and updated_at.
class CreateFriendships < ActiveRecord::Migration[7.1]
  def change
    create_table :friendships do |t|
      t.integer :follower_id
      t.integer :followed_id
      t.string :status

      t.timestamps
    end
  end
end
