class FeedsController < ApplicationController
  def index
    @users = User.all 
    @posts = Post.all
    @comments = Comment.all
    @popularposts = Post.order(comment_counts: :desc).limit(10)
  end
end
