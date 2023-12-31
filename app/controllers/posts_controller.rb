# frozen_string_literal: true

# Controller for posts
class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index]

  def index
    if user_signed_in?
      @new_post = Post.new # Initialize a new post for the form
      # Get IDs of approved friends
      friend_ids = current_user.followers.where(friendships: { status: 'approved' }).pluck(:id)
     
      # Include the current user's ID in the list
      user_ids = friend_ids << current_user.id

      # Fetch posts from current user and approved friends
      @posts = Post.where(user_id: user_ids).order(created_at: :desc)
    else
      redirect_to new_user_registration_path
    end
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      redirect_to posts_path, notice: 'Post was successfully created.'
    else
      render :new
    end
  end

  private

  def post_params
    params.require(:post).permit(:text)  # Adjust according to your post attributes
  end
end
