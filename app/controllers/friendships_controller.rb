# frozen_string_literal: true

# app/controllers/friendships_controller.rb
class FriendshipsController < ApplicationController
  def create
    @friendship = current_user.following_relationships.build(followed_id: params[:followed_id], status: 'pending')
    if @friendship.save
      # Redirect or respond as necessary
      create_notification_for(@friendship)
      Turbo::StreamsChannel.broadcast_refresh_to "friend_request"
      Turbo::StreamsChannel.broadcast_refresh_to "notification_event"
      redirect_to friendships_path, notice: 'Friend request sent'
    else
      # Handle errors
      flash[:alert] = 'Unable to send friend request.'
      redirect_back(fallback_location: root_path)
    end
  end

  def update
    @friendship = Friendship.find(params[:id])
    if @friendship.update(status: 'approved')
      # Redirect or respond as necessary
    else
      # Handle errors
      flash[:alert] = 'Unable to update friend request.'
      redirect_back(fallback_location: root_path)
    end
  end

  def index
    @users = User.where.not(id: current_user.id)

    # retrieve the users who have sent a follow request to the current user and are waiting for approval
    @pending_followers = current_user.follower_relationships.includes(:follower).where(status: 'pending')

    # retrieve the users whom the current user has sent a follow request to and are waiting for their approval
    @pending_following = current_user.following_relationships.includes(:followed).where(status: 'pending')

    # retrieve the users who are approved followers of the current user
    @approved_followers  = current_user.follower_relationships.includes(:follower).where(status: 'approved')
  end

  def approve
    puts params.inspect
    friendship = Friendship.find(params[:id])
    if friendship.update(status: 'approved')
      redirect_to friendships_path, notice: 'Friend request approved'
    else
      # Handle errors
      flash[:alert] = 'Unable to approve friend request.'
      redirect_back(fallback_location: root_path)
    end
  end

  def decline
    puts params.inspect
    friendship = Friendship.find(params[:id])
    if friendship.destroy
      # Redirect if friendship is declined
      redirect_to friendships_path, notice: 'Friend request declined'
    else
      # Handle errors
      flash[:alert] = 'Unable to decline friend request.'
      redirect_back(fallback_location: root_path)
    end
  end

  def create_notification_for(friendship)
    Notification.create(
      user_id: friendship.followed_id
    )
  end
end
