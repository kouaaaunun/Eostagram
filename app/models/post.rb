class Post < ApplicationRecord
  belongs_to :user
  has_many :photos, dependent: :destroy
  has_many :loves, -> {order(:created_at => :desc)}

  def is_belongs_to? user
    Post.find_by(user_id: user.id, id: id)
  end
  def is_loved user
    Love.find_by(user_id: user.id, post_id: id)
  end

end
