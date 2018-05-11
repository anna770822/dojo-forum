class PostsController < ApplicationController
  skip_before_action :authenticate_user!, only: :index
  impressionist actions: [:show]
  before_action :set_post, only: [:show, :destroy, :edit, :update, :edit_comments]
  def index
    @q = Post.where(public: true).ransack(params[:q])
    @posts = @q.result(distinct: true).page(params[:page]).per(20)
    @categories = Category.all
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)
    if params[:commit] == "Publish"
      @post.public = true
      if @post.save
        redirect_to root_path
      else
        redirect_to root_path
        flash[:alert]= @post.errors.full_messages.to_sentence
      end
    else
      @post.public = false
      if @post.save
        redirect_to root_path
      else
        redirect_to root_path
        flash[:alert]= @post.errors.full_messages.to_sentence
      end
    end
  end

  def show
    @comment = Comment.new
    @comments = Comment.where(post_id: @post.id).page(params[:page]).per(20)
  end

  def destroy
 
    if @post.public
      @post.destroy
      redirect_to root_path
    else
      @post.destroy
      redirect_to user_path(current_user)
    end
  end


  def update
    if params[:commit] == "Publish"
      @post.public = true
      if @post.update_attributes(post_params)
        redirect_to root_path
      else
        render :edit
        flash[:alert]= @post.errors.full_messages.to_sentence
      end
    else
      @post.public = false
      if @post.update_attributes(post_params)
        redirect_to root_path
      else
        render :edit
        flash[:alert]= @post.errors.full_messages.to_sentence
      end
    end
  end

  def collect
    @post = Post.find(params[:post_id])
    @collect = current_user.collections.build(post_id: @post.id)
    @collect.save
    redirect_to post_path(@post)
  end

  def uncollect
    @post = Post.find(params[:post_id])
    @collect = current_user.collections.where(post_id: @post.id)
    @collect.destroy_all
    redirect_to post_path(@post)
  end

  private

  def post_params
    params.require(:post).permit(:title, :content, :image, :public, :category_ids => [])
  end

  def set_post
    @post = Post.find(params[:id])
  end

end
