class Api::V1::PostsController < ApiController
  before_action :authenticate_user!, except: :index
  before_action :set_category, only: [:index]
  before_action :set_post, only: [:show, :destroy, :update, :check_user]
  before_action :check_user, only: [:update, :destroy]
  def index
    if current_user
      @q = Post.where(public: true).authorized_posts(current_user).ransack(params[:q])
      @posts = @q.result(distinct: true).page(params[:page]).per(20)
      respond_to do |format|
        format.json{
          render json: {:posts => @posts, 
                        :categories => @categories
          }
        }
      end
    else
      @q = Post.where(public: true).where(authority: "All").ransack(params[:q])
      @posts = @q.result(distinct: true).page(params[:page]).per(20)
      respond_to do |format|
        format.json{
          render json: {:posts => @posts, 
                        :categories => @categories
          }
        }
      end
    end
  end

  def show
    if Post.authorized_posts(current_user).post_public.include?(@post)
      @post.view_counts += 1
      @post.save!
      @comments = Comment.where(post_id: @post.id).page(params[:page]).per(20)
      respond_to do |format|
        format.json{
          render json: {:post => @post, 
                        :comments => @comments
          }
        }
      end
    else
      render json: {
        errors: "You have no right to this post!"
      }
    end
  end
  
  def create

    @post = current_user.posts.build(post_params)
    if @post.save
      render json: {
        message: "Post Created!",
        result: @post
      }
    else
      render json: {
        errors: @post.errors
      }
    end
  end

  def update
    if @post.update(post_params)
      render json: {
        message: "Post Updated!",
        result: @post
      }
    else
      render json: {
        errors: @post.errors
      }
    end
  end

  def destroy
    @post.destroy
    render json: {
      message: "Post Deleted!"
    }

  end


  private 

  def set_category
    @categories = Category.all
  end

  def set_post
    @post = Post.find_by(id: params[:id])
  end

  def post_params
    params.permit(:title, :content, :image, :public, :authority, category_ids: [])
  end

  def check_user
    unless @post.user == current_user || current_user.admin?
      render json: {
        errors: "You have no right to this post!"
      }
    end
  end
end
