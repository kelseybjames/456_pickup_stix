class UsersController < ApplicationController
  skip_before_action :require_login, only: [:index, :show, :new, :create]
  before_action :require_current_user, only: [:edit, :update, :destroy]

  def index
    @users = User.includes(:playlists)
  end

  def new
    @user = User.new
  end

  def create
    if signed_in_user?
      flash[:error] = 'Already logged in'
      redirect_to root_path
    else
      @user = User.new(whitelisted_user_params)
      if @user.save
        sign_in(@user)
        flash[:success] = "Welcome, #{@user.first_name}!"
        redirect_to user_path(@user)
      else
        flash.now[:error] = 'Failed to create user'
        render :new
      end
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(whitelisted_user_params)
      flash[:success] = 'User updated'
      redirect_to user_path(current_user)
    else
      flash.now[:error] = 'Failed to update'
      render :edit
    end
  end

  def destroy
    if current_user.destroy
      sign_out
      flash[:success] = 'User destroyed'
      redirect_to root_path
    else
      flash[:error] = 'User failed to destroy'
      redirect_to root_path
    end
  end

  private

  def whitelisted_user_params
    params.require(:user).permit(:first_name,
                                 :last_name,
                                 :email,
                                 :password,
                                 :password_confirmation)
  end

  def extract_bookmarkable
    params[:bookmarkable].constantize
  end

  def id_type
    type = params[:bookmarkable]
    (type.downcase + '_id').to_sym
  end
end
