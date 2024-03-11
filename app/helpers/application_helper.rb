# frozen_string_literal: true

# This is the ApplicationHelper module.
module ApplicationHelper
  # Generates a Gravatar URL for a given user.
  def gravatar_for(user, options = { size: 80 })
    if user.profile_picture.attached?
      user.profile_picture
    elsif user.avatar_url.present?
      user.avatar_url
    else
      gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
      size = options[:size]
      identicon = 'd=monsterid'
      gravatar_url = "https://www.gravatar.com/avatar/#{gravatar_id}?s=#{size}&#{identicon}"
    end
  end
end

