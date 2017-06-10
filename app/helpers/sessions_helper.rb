module SessionsHelper
  def login_check
    redirect_to login_path if session[:user_id].nil?
  end
end
