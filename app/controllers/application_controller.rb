class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :require_login

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user


  def signed_in_user?
    !!current_user
  end
  helper_method :signed_in_user?


  def is_current_user?(user)
    signed_in_user? && user.id == current_user.id
  end
  helper_method :is_current_user?




  protected
  def sign_in(user)
    session[:user_id] = user.id
    @current_user = user
    @current_user == user && session[:user_id] == user.id
  end


  def sign_out
    @current_user = session[:user_id] = nil
    @current_user.nil? && session[:user_id].nil?
  end


  def require_login
    unless signed_in_user?
      flash[:error] = 'That action requires you to be logged in'
    end
    redirect_to login_path
  end


  def require_logout
    if signed_in_user?
      flash[:error] = 'Logout first!'
      redirect_to root_path
    end
  end

  def require_current_user
    unless params[:id] == current_user.id.to_s
      flash[:error] = "You're not authorized to view this"
      redirect_to root_url
    end
  end
end
