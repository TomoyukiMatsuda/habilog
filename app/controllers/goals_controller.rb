class GoalsController < ApplicationController
  before_action :correct_user, only: [:edit, :update, :destroy]

  def index
    @goals = current_user.goals.order(id: :desc).page(params[:page]).per(5)
  end

  def new
    @goal = Goal.new
  end

  def create
    @goal = current_user.goals.build(goal_params)
    
    if @goal.save
      flash[:success] = '新しい目標を設定しました'
      redirect_to new_goal_good_habit_url(@goal)
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
