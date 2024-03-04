#  frozen_string_literal: true

# Controller for comments.
class CommentsController < ApplicationController
  before_action :authenticate_user! # Assuming you're using Devise for user authentication

  def create
    @comment = current_user.comments.new(comment_params)

    if @comment.save
      # Handle the successful save (e.g., redirect or render)
      Turbo::StreamsChannel.broadcast_refresh_to "comment_event"
      redirect_to posts_path
    else
      # Handle the error (e.g., render the form again with error messages)
      render 'posts/index', status: :unprocessable_entity
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:text, :commentable_type, :commentable_id)
  end
end
