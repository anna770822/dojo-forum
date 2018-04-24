class Admin::UsersController < ApplicationController
  before_action :authenticate_admin
  def index
    @users = User.all
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_param)
    redirect_to admin_users_path
  end

  private

  def user_param
    params.require(:user).permit(:name, :email, :role)
  end
end
