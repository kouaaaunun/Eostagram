module ApplicationHelper
  def avatar_url user
    return user.image if user.image
    gravatar_id = Digest::MD5::hexdigest(user.email).downcase
    "https://www.gravatar.com/avatar/#{gravatar_id}.jpg"
  end
  def current_user_is_following(current_user_id, following_id)
    follow_relationship = Follow.find_by(follower_id: current_user_id, following_id: following_id)
    return true if follow_relationship
  end

end