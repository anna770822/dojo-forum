class PostsController < ApplicationController
  skip_before_action :authenticate_user!, only: :index
  impressionist actions: [:show]
  before_action :set_post, only: [:show, :destroy, :edit, :update, :edit_comments]
  def index
    if current_user
      @q = Post.where(public: true).authorized_posts(current_user).ransack(params[:q])
      @posts = @q.result(distinct: true).page(params[:page]).per(20).order(updated_at: :desc)
    else
       @q = Post.where(public: true).where(authority: "All").ransack(params[:q])
       @posts = @q.result(distinct: true).page(params[:page]).per(20).order(updated_at: :desc)
    end
    @categories = Category.all
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user = current_user
    if params[:commit] == "Publish"
      @post.public = true
      if @post.save
        redirect_to root_path
      else
        flash.now[:alert]= @post.errors.full_messages.to_sentence
        render :edit
      end
    else
      @post.public = false
      if @post.save
        redirect_to drafts_user_path(current_user)
      else
        flash.now[:alert]= @post.errors.full_messages.to_sentence
        render :edit
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
      redirect_to drafts_user_path(current_user)
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
    params.require(:post).permit(:title, :content, :image, :public, :authority, :category_ids => [])
  end

  def set_post
    @post = Post.find(params[:id])
  end

end
