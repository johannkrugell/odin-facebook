# frozen_string_literal: true

require 'test_helper'

class LikesControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @user = users(:user1)
    @post = posts(:example_post)
    sign_in @user
  end

  test 'should like a post' do
    assert_difference('Like.count', 1) do
      post post_likes_path(@post)
    end
    assert_redirected_to posts_path
    @post.reload
    assert_equal 1, @post.likes_count
  end

  test 'should unlike a post' do
    # Create a like first
    @post.likes.create(user: @user)

    assert_difference('Like.count', -1) do
      delete post_like_path(@post, @post.likes.find_by(user: @user))
    end
    assert_redirected_to posts_path
    @post.reload
    assert_equal 0, @post.likes_count
  end
end
