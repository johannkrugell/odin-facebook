# frozen_string_literal: true

# Comment model to store comments on posts by users
class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post
end
