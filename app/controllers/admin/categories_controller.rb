class Admin::CategoriesController < ApplicationController
  before_action :authenticate_admin
  def index
    @categories = Category.all

    if params[:id]
      @category = Category.find(params[:id])
    else
      @category = Category.new
    end
  end

  def create
    @category = Category.new(category_param)
    if @category.save
      redirect_to admin_categories_path
    else
      render :new
    end
  end

  def destroy
    @category = Category.find(params[:id])
    @category.destroy
    redirect_to admin_categories_path
  end
    
  def update
    @category = Category.find(params[:id])
    @category.update(category_param)
    redirect_to admin_categories_path
  end

  private

  def category_param
    params.require(:category).permit(:name)
  end
end
