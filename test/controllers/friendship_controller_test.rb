# frozen_string_literal: true

require 'test_helper'

class FriendshipsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers # Devise helpers for authentication
  def setup
    @user1 = users(:user1)  # Replace with your fixture user
    @user2 = users(:user2)  # Replace with another fixture user
  end

  test 'should create friendship request' do
    sign_in @user1
    assert_difference 'Friendship.count' do
      post friendships_path, params: { followed_id: @user2.id }
    end
    assert_redirected_to friendships_path
  end

  test 'should approve friendship request' do
    sign_in @user2
    friendship = Friendship.create(follower: @user1, followed: @user2, status: 'pending')

    assert_changes 'friendship.reload.status', from: 'pending', to: 'approved' do
      patch approve_friendship_path(friendship)
    end
    assert_redirected_to friendships_path
  end

  test 'should decline friendship request' do
    sign_in @user2
    friendship = Friendship.create(follower: @user1, followed: @user2, status: 'pending')

    assert_difference 'Friendship.count', -1 do
      delete decline_friendship_path(friendship)
    end
    assert_redirected_to friendships_path
  end
end
