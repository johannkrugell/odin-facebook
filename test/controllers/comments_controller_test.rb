# frozen_string_literal: true

require 'test_helper'

class CommentsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @user = users(:user1)
    @post = posts(:one)
    sign_in @user
  end

  test "should create comment" do
    assert_difference('Comment.count') do
      post post_comments_path(@post), params: { comment: { text: "This is a test comment." } }
    end

    assert_redirected_to posts_path
    follow_redirect!
    assert_match "This is a test comment.", response.body
  end
end
