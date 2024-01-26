# frozen_string_literal: true

class AddReadToNotifications < ActiveRecord::Migration[7.1]
  def change
    add_column :notifications, :read, :boolean
  end
end
