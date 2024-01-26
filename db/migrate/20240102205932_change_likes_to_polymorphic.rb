# frozen_string_literal: true

class ChangeLikesToPolymorphic < ActiveRecord::Migration[7.1]
  def change
    remove_reference :likes, :post, index: true, foreign_key: true
    add_reference :likes, :likeable, polymorphic: true, index: true
  end
end
