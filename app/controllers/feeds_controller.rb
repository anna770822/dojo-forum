class FeedsController < ApplicationController
  def index
    @user_count = User.count
    @post_count = Post.count
    @comment_count = Comment.count
    @popularposts = Post.order(comment_counts: :desc).limit(10)
    @activeusers = User.order(comment_counts: :desc).limit(10)
  end
end
