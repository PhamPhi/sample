class User < ActiveRecord::Base

  has_many :microposts, dependent: :destroy
  has_many :relationships, foreign_key: "follower_id", dependent: :destroy
  has_many :followed_users, through: :relationships, source: :followed
  has_many :reverse_relationships, foreign_key: "followed_id", class_name: "Relationship", dependent: :destroy
  has_many :followers, through: :reverse_relationships, source: :follower
 # validates(:name, presence: true)
  validates :name, presence: true, length: { maximum: 50}
  VALID_EMAIL_REGEX =  /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: {with:  VALID_EMAIL_REGEX}, uniqueness: {case_sensitive: false}
  before_save { self.email = email.downcase }

  has_secure_password
  validates :password, length: { minimum: 6 }
  
  # Method define the new token for the 'remember  me' functionality
  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end
  
  def User.encrypt(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  # Method feed to used the auto posting...
  def feed
    # This is preliminary.. See "Following users"

    Micropost.where("user_id= ?", id)
  end

  def following?(other_user)

    relationships.find_by(followed_id: other_user.id)
  end

  def follow!(other_user)
    relationships.create!(followed_id: other_user.id)
  end

  def unfollow!(other_user)
    relationships.find_by(followed_id: other_user.id).destroy!
  end
  # Private method used to create the way to remember token..
  private
    def create_remember_token
      # create the token
      self.remember_token = User.encrypt(User.new_remember_token)
    end
end
