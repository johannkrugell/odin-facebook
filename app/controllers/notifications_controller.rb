# frozen_string_literal: true

# Notifications controller
class NotificationsController < ApplicationController
  def index
    @notifications = current_user.notifications.where(read: false)

    # Respond with Turbo Stream to update the UI
    respond_to do |format|
      format.turbo_stream
      format.html
    end
  end

  def dismiss
    notification = current_user.notifications.find(params[:id])
    notification.update(read: true)

    # Respond with Turbo Stream to update the UI
    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to notifications_path }
    end
  end
end
