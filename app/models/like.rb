# frozen_string_literal: true

# This is the Like model. It stores likes on posts by users.
class Like < ApplicationRecord
  belongs_to :user
  belongs_to :post, counter_cache: true
end
