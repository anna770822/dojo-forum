class Post < ApplicationRecord
  has_many :comments
  has_many :commented_users, through: :comments , source: :user
  
  belongs_to :user
end
