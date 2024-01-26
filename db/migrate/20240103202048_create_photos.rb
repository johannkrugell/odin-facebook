# frozen_string_literal: true

class CreatePhotos < ActiveRecord::Migration[7.1]
  def change
    create_table :photos do |t|
      t.references :user, null: false, foreign_key: true
      t.references :post, null: true, foreign_key: true  # Optional reference to a post

      t.timestamps
    end
  end
end
