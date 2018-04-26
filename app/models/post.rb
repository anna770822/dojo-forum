class Post < ApplicationRecord
  is_impressionable :counter_cache => true, :column_name => :view_counts
  mount_uploader :image, PostUploader
  has_many :comments, dependent: :destroy
  has_many :commented_users, through: :comments , source: :user
  
  belongs_to :user

  has_many :category_posts
  has_many :categories, through: :category_posts

  def comment_counts
    self.comment_counts = self.comments.size
    self.save
  end

end
