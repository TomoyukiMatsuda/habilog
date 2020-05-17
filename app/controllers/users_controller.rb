class UsersController < ApplicationController
  before_action :require_user_logged_in, only: [:show, :edit, :update]
  before_action :set_user, only: [:show, :edit, :update]
  
  
  
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    
    if @user.save
      flash[:success] = 'アカウントを作成しました'
      session[:user_id] = @user.id # sessionにuser_idを格納することでアカウント作成と同時にログイン
      redirect_to root_url
    else
      flash.now[:danger] = 'アカウントの作成に失敗しました'
      render :new
    end
  end
  
  def show
  end

  def edit
  end

  def update
    if @user.update_attributes(user_params)
      flash[:success] = 'ユーザ情報を更新しました'
      redirect_to @user
    else
      flash.now[:danger] = 'ユーザ情報の更新に失敗しました'
      render :edit
    end
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name, :age, :profile, :email, :password, :password_confirmation)
  end
  
  def set_user
    @user = User.find(params[:id])
  end
end
