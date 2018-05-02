class CategoriesController < ApplicationController

  def show
    @category = Category.find(params[:id])
    @categories = Category.all
    @categoryposts = CategoryPost.where(category_id: @category.id)
  end
end
