class User < ApplicationRecord
  # Include default devise modules. Others available are:
  has_many :posts, dependent: :destroy
  has_many :events, dependent: :destroy
  has_many :likes
  has_many :loves
  has_many :comments
  has_many :bookmarks
  has_many :follower_relationships, foreign_key: :following_id, class_name: 'Relation', dependent: :destroy
  has_many :followers, through: :follower_relationships, source: :follower
  has_many :following_relationships, foreign_key: :follower_id, class_name: 'Relation', dependent: :destroy
  has_many :following, through: :following_relationships, source: :following


  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, 
         :omniauthable, omniauth_providers: %i[google_oauth2]
  validates :name, presence: true, length: {maximum: 50}

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.name = auth.info.name   # assuming the user model has a name
      user.image = auth.info.image # assuming the user model has an image
      user.uid = auth.uid
      user.provider = auth.provider
      # If you are using confirmable and the provider(s) you use validate emails,
      # uncomment the line below to skip the confirmation emails.
      # user.skip_confirmation!
    end
  end
  def self.search(term)
    if term
      where('name LIKE ?', "%#{term}%")
    else
      nil
    end
  end
  
  def follow(user_id)
    following_relationships.create(following_id: user_id)
  end

  def unfollow(user_id)
    following_relationships.find_by(following_id: user_id).destroy
  end


end
