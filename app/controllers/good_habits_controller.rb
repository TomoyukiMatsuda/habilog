class GoodHabitsController < ApplicationController
  before_action :require_user_logged_in
  before_action :destroy_correct_user, only: :destroy
  before_action :habit_correct_user, only: [:new, :create]
  
  
  def new
    @good_habit = GoodHabit.new
  end

  def create
    @good_habit = GoodHabit.new(good_habit_params)
    
    if @good_habit.save
      flash[:success] = "習慣を追加しました"
      redirect_to new_goal_bad_habit_url(params[:goal_id])
    else
      @goal = Goal.find(params[:goal_id])
      @good_habit = GoodHabit.new
      flash.now[:danger] = "習慣の追加に失敗しました"
      render :new
    end
  end

  def destroy
    @good_habit.destroy
    flash[:success] = '習慣を削除しました'
    redirect_back(fallback_location: goals_url)
  end
  
  private
  
  def good_habit_params
    params.require(:good_habit).permit(:name, :goal_id)
  end
  
  def destroy_correct_user
    goal = current_user.goals.find_by(id: params[:goal_id])
    @good_habit = goal.good_habits.find_by(id: params[:id])
    unless @good_habit
      flash[:danger] = 'エラー'
      redirect_to root_url
    end
  end
end
