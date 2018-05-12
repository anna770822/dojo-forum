class CategoriesController < ApplicationController

  def show
    @category = Category.find(params[:id])
    @categories = Category.all

    @q = @category.posts.ransack(params[:q])
    @posts = @q.result(distinct: true).page(params[:page]).per(20).order(updated_at: :desc)
  end
end
