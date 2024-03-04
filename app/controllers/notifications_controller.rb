# frozen_string_literal: true

# Notifications controller
class NotificationsController < ApplicationController
  def index
    @notifications = current_user.notifications.where(read: false)
    Turbo::StreamsChannel.broadcast_refresh_to "notification_event"
  end

  def dismiss
    notification = current_user.notifications.find(params[:id])
    if notification.update(read: true)
      Turbo::StreamsChannel.broadcast_refresh_to "notification_event"
      redirect_to friendships_path, notice: 'Notification dismissed'
    else
      redirect_to root_path, alert: 'Unable to dismiss notification.'
    end
  end
end
