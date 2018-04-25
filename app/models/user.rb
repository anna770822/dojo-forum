class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :commented_posts, through: :comments, source: :post
  has_many :comments

  has_many :posts, dependent: :destroy

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
end
