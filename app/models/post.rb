class Post < ApplicationRecord
  is_impressionable :counter_cache => true, :column_name => :view_counts
  mount_uploader :image, PostUploader
  
  validates :category_ids, presence: true

  has_many :comments, dependent: :destroy
  has_many :commented_users, through: :comments , source: :user
  
  belongs_to :user

  has_many :category_posts, dependent: :destroy
  has_many :categories, through: :category_posts

  has_many :collections, dependent: :destroy
  has_many :users, through: :collections

  def comment_counts
    self.comment_counts = self.comments.size
    self.save
  end

  def self.authorized_posts(user)
    Post.where(authority: "All").or(where(authority: "Friend", user: user.all_friends)).or(where(authority: "Myself", user: user))
  end
end
