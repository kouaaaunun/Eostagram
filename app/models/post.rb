class Post < ApplicationRecord
  belongs_to :user
  has_many :photos, dependent: :destroy
  has_many :loves, -> {order(:created_at => :desc)}, dependent: :destroy
  has_many :comments, -> {order(:created_at => :desc)}, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
  has_many :post_hash_tags
  has_many :hash_tags, through: :post_hash_tags
  after_commit :create_hash_tags, on: :create

  
  def is_belongs_to? user
    Post.find_by(user_id: user.id, id: id)
  end
  def is_loved user
    Love.find_by(user_id: user.id, post_id: id)
  end
  def is_bookmarked user
    Bookmark.find_by(user_id: user.id, post_id: id)
  end
  def create_hash_tags
    extract_name_hash_tags.each do |name|
     tag = HashTag.find_or_create_by(name: name)
     self.hash_tags << tag
    end
  end
  def extract_name_hash_tags
    content.to_s.scan(/#\w+/).map{|name| name.gsub("#", "")}
  end

end
