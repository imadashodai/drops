class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update, :destroy]

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    redirect_to action: :index if @user.save
  end

  def edit
  end

  def update
    redirect_to action: :index if @user.update(user_params)
  end

  def destroy
    redirect_to action: :index if @user.delete
  end

  private
  def user_params
    params.require(:user).permit(:name, :account_name, :password, :password_confirmation)
  end

  def set_user
    @user = User.find_by(id: params[:id])
  end
end
