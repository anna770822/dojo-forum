class CommentsController < ApplicationController
  before_action :find_post, only: [:create, :destroy, :edit, :update]
  
  def create
  
    @comment = @post.comments.new(comment_params)
    @comment.user = current_user

    @post.count_comment
    @post.save

    current_user.count_comment
    current_user.save

    @comment.save
    redirect_to post_path(@post)
  end

  def destroy

    @comment = Comment.where(post_id: @post).find(params[:comment_id])
    @comment.destroy
    redirect_to post_path(@post)
  end

  def edit
    @comment = Comment.where(post_id: @post).find(params[:comment_id])
  end

  def update
    @comment = Comment.where(post_id: @post).find(params[:id])
    @post = @comment.post
    if @comment.update_attributes(comment_params)
      redirect_to post_path(@post)
    else
      render :edit
    end

  end
  

  private

  def comment_params
    params.require(:comment).permit(:content, :post_id, :user_id, :image)
  end

  def find_post
    @post = Post.find(params[:post_id])
  end
end
