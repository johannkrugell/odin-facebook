# frozen_string_literal: true

require 'test_helper'

class PostsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers # Devise helpers for authentication

  test 'should create post for logged in user' do
    user = users(:user1) # See users.yml fixture
    sign_in user # Sign in a user for the test

    assert_difference('Post.count') do
      post posts_path, params: { post: { text: 'New post content' } } # Adjust with your post parameters
    end

    assert_redirected_to posts_path # Expect redirect to the posts index page
    follow_redirect! # Optional: follow the redirect to confirm it leads to the correct page
    assert_response :success # Optional: check that the posts index page is displayed

    assert_equal 'New post content', Post.last.text # Optionally check that the post content is as expected
  end
end
