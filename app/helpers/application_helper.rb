# frozen_string_literal: true

# This is the ApplicationHelper module.
module ApplicationHelper
  # Generates a Gravatar URL for a given user.
  def gravatar_for(user, options = { size: 80 })
    email_address = user.email.downcase
    hash = Digest::MD5.hexdigest(email_address)
    size = options[:size]
    identicon = 'd=monsterid'
    "https://www.gravatar.com/avatar/#{hash}?s=#{size}&#{identicon}"
  end
end
