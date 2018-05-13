class CategoriesController < ApplicationController

  def show
    @category = Category.find(params[:id])
    @categories = Category.all

    @q = @category.posts.where(public: true).authorized_posts(current_user).ransack(params[:q])
    @posts = @q.result(distinct: true).page(params[:page]).per(20).order(updated_at: :desc)
  end
end
