class GoalsController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:edit, :update, :destroy]
  
  
  def index
    @goals = current_user.goals.order(id: :desc).page(params[:page])
  end

  def new
    @goal = Goal.new
  end

  def create
    @goal = current_user.goals.build(goal_params)
    
    if @goal.save
      flash[:success] = '新しい目標を設定しました'
      redirect_to goals_path #後ほど習慣登録画面に遷移するように変更
    else
      flash.now[:danger] = '目標設定に失敗しました'
      render :new
    end
  end

  def edit
  end

  def update
    if @goal.update(goal_params)
      flash[:success] = '目標を編集しました'
      redirect_to goals_path
    else
      flash.now[:danger] = '目標の編集に失敗しました'
      render :edit
    end
  end

  def destroy
    @goal.destroy
    flash[:success] = '目標を削除しました'
    redirect_to goals_path
  end
  
  private
  
  def goal_params
    params.require(:goal).permit(:name)
  end

  def correct_user
    @goal = current_user.goals.find_by(id: params[:id])
    unless @goal
      redirect_to root_url
    end
  end
end