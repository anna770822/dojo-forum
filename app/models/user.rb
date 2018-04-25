class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :commented_posts, through: :comments, source: :post
  has_many :comments

  has_many :posts

  def admin?
    self.role == "Admin"
  end
end
