class Post < ApplicationRecord
  mount_uploader :image, PostUploader
  has_many :comments, dependent: :destroy
  has_many :commented_users, through: :comments , source: :user
  
  belongs_to :user
  
  has_many :category_posts
  has_many :categories, through: :category_posts

end
