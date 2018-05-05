class CommentsController < ApplicationController


  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.new(comment_params)
    @comment.user = current_user
    @post.comment_counts
    current_user.comment_counts
    @comment.save
    redirect_to post_path(@post)
  end

  def destroy
    @post = Post.find(params[:post_id])
    @comment = Comment.where(post_id: @post).find(params[:comment_id])
    @comment.destroy
    redirect_to post_path(@post)
  end


  private

  def comment_params
    params.require(:comment).permit(:content, :post_id, :user_id, :image)
  end
end
