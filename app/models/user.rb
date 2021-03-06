class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  mount_uploader :avatar, AvatarUploader 

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  before_create :generate_authentication_token

  has_many :commented_posts, through: :comments, source: :post
  has_many :comments

  has_many :posts, dependent: :destroy

  has_many :friendships, -> {where status: true}, dependent: :destroy
  has_many :friends, through: :friendships

  has_many :inverse_friendships, -> {where status: true}, class_name: "Friendship", foreign_key: "friend_id"
  has_many :inverse_friends, through: :inverse_friendships, source: :user

  has_many :not_yet_accepted_friendships, -> {where status: false}, class_name: "Friendship", dependent: :destroy
  has_many :not_yet_accepted_friends, through: :not_yet_accepted_friendships, source: :friend

  has_many :not_yet_responded_friendships, -> {where status: false}, class_name: "Friendship", foreign_key: "friend_id", dependent: :destroy
  has_many :not_yet_responded_friends, through: :not_yet_responded_friendships, source: :user
  
  has_many :collections, dependent: :destroy
  has_many :posts, through: :collections

  def admin?
    self.role == "Admin"
  end

  def check_avatar(user)
    if user.avatar.nil?
      "avatar.png"
    else
      user.avatar
    end
  end

  def count_comment
    self.comment_counts = self.comments.size
    self.save
  end

  def friend?(user)
    self.friends.include?(user) || self.inverse_friends.include?(user)
  end

  def not_yet_accepted_friends?(user)
    self.not_yet_accepted_friends.include?(user)
  end

  def not_yet_responded_friends?(user)
    self.not_yet_responded_friends.include?(user)
  end
  
  def all_friends
    friends = self.friends + self.inverse_friends
    return friends.uniq
  end

  def generate_authentication_token
    self.authentication_token = Devise.friendly_token
  end
end
