class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(account_name: params[:sessions][:account_name])
    if user && user.authenticate(params[:sessions][:password])
      session[:user_id] = user.id
      redirect_to users_path
    else
      render :new
    end
  end

  def destroy
    session.delete(:user_id)
    redirect_to login_path
  end
end
