class UsersController < ApplicationController
  before_action :require_user_logged_in, only: [:edit, :update]
  
  
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    
    if @user.save
      flash[:success] = 'アカウントを作成しました'
      redirect_to root_url
    else
      flash.now[:danger] = 'アカウントの作成に失敗しました'
      render :new
    end
  end

  def edit
  end

  def update
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name, :age, :profile, :email, :password, :password_confirmation)
  end
end
