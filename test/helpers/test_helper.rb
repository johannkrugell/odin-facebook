# frozen_string_literal: true

module ActiveSupport
  class TestCase
    include Devise::Test::IntegrationHelpers

    # Other setup

    def sign_in_user
      user = users(:example_user) # Assuming you have fixture users set up
      sign_in user
      user
    end
  end
end
