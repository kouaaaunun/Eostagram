class Event < ApplicationRecord
  belongs_to :user
  has_many :likes, -> {order(:created_at => :desc)}, dependent: :destroy
  has_many :eventhashes
  has_many :hash_tags, through: :eventhashes
  after_commit :create_hash_tags, on: :create

  def is_belongs_to? user
    Event.find_by(user_id: user.id, id: id)
  end
  def is_liked user
    Like.find_by(user_id: user.id, event_id: id)
  end
  
  def create_hash_tags
    extract_name_hash_tags.each do |name|
     tag = HashTag.find_or_create_by(name: name)
     self.hash_tags << tag
    end
  end
  def extract_name_hash_tags
    hashtag.to_s.scan(/#\w+/).map{|name| name.gsub("#", "")}
  end

  
end
