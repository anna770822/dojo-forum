class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :commented_posts, through: :comments, source: :post
  has_many :comments

  has_many :posts, dependent: :destroy

  has_many :friendships, -> {where status: true}, dependent: :destroy
  has_many :friends, through: :friendships

  has_many :inverse_friendships, -> {where status: true}, class_name: "Friendships", foreign_key: "friend_id"
  has_many :inverse_friends, through: :inverse_friendships, source: :user

  has_many :not_yet_accepted_friendships, -> {where status: false}, class_name: "Friendship", dependent: :destroy
  has_many :not_yet_accepted_friends, through: :not_yet_accepted_friendships, source: :friend

  has_many :not_yet_responded_friendships, -> {where status: false}, class_name: "Friendship", foreign_key: "friend_id", dependent: :destroy
  has_many :not_yet_responded_friends, through: :not_yet_responded_to_friendships, source: :user


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

  def comment_counts
    self.comment_counts = self.comments.size
    self.save
  end
end
