# frozen_string_literal: true

# LikesController to add and remove likes from posts
class LikesController < ApplicationController
  before_action :like_params

  def create
    @like = current_user.likes.new(like_params)
    @like.save
    Turbo::StreamsChannel.broadcast_refresh_to "like_event"
    redirect_to posts_path  # Adjust the redirect path as needed
  end

  def destroy
    @like = current_user.likes.find(params[:id])
    @like&.destroy
    Turbo::StreamsChannel.broadcast_refresh_to "like_event"
    redirect_to posts_path  # Adjust the redirect path as needed
  end

  private

  def like_params
    params.permit(:likeable_id, :likeable_type)
  end
end
