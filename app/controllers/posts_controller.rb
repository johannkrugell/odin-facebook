# frozen_string_literal: true

# Controller for posts
class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  before_action :set_post, only: %i[show destroy]
  before_action :check_user, only: [:destroy]

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
      if params[:post][:photo].present?
        photo = @post.photos.build(user: current_user)
        photo.image.attach(params[:post][:photo])
        photo.save
      end
      Turbo::StreamsChannel.broadcast_refresh_to "post_event"
      redirect_to posts_path, notice: 'Post was successfully created.'
    else
      render :new
    end
  end

  def show
    @comments = @post.comments.order(created_at: :desc)
  end

  def destroy
    if @post.destroy
      redirect_to posts_path, notice: 'Post was successfully deleted.'
    else
      redirect_to posts_path, alert: 'Unable to delete the post.'
    end
  end

  private

  def post_params
    params.require(:post).permit(:text) # Permit :photo as a parameter
  end

  def set_post
    @post = Post.find(params[:id])
  end

  def check_user
    redirect_to(root_path, alert: 'Unauthorized action.') unless @post.user_id == current_user.id
  end
end
