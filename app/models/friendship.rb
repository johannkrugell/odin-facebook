# frozen_string_literal: true

# Friendship relationships to users
class Friendship < ApplicationRecord
  belongs_to :follower, class_name: 'User'
  belongs_to :followed, class_name: 'User'
end
