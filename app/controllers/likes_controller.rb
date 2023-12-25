# frozen_string_literal: true

# LikesController to add and remove likes from posts
class LikesController < ApplicationController
  before_action :find_post

  def create
    @post.likes.create(user_id: current_user.id)
    redirect_to posts_path  # Adjust the redirect path as needed
  end

  def destroy
    like = @post.likes.find_by(user_id: current_user.id)
    like.destroy if like
    redirect_to posts_path  # Adjust the redirect path as needed
  end

  private

  def find_post
    @post = Post.find(params[:post_id])
  end
end
