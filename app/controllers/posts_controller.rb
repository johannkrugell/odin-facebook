# frozen_string_literal: true

# Controller for posts
class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index]

  def index
    if user_signed_in?
      @posts = Post.all
    else
      redirect_to new_user_registration_path
    end
  end
end
