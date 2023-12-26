#  frozen_string_literal: true

# Controller for comments.
class CommentsController < ApplicationController
  before_action :authenticate_user!  # Assuming you're using Devise for user authentication

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(comment_params)
    @comment.user = current_user

    if @comment.save
      # Handle the successful save (e.g., redirect or render)
      redirect_to posts_path
    else
      # Handle the error (e.g., render the form again with error messages)
      render 'posts/index', status: :unprocessable_entity
    end
  end

  def show
    @post = Post.find(params[:id])
    @comments = @post.comments.order(created_at: :desc)

  end
  
  private

  def comment_params
    params.require(:comment).permit(:text, :post_id)
  end
end
