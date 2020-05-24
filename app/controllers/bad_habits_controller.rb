class BadHabitsController < ApplicationController
  before_action :habit_correct_user

  def new
    @bad_habit = BadHabit.new
  end
  
  def create
    @bad_habit = BadHabit.new(bad_habit_params)
    
    if @bad_habit.save
      flash[:success] = "やめるべき習慣を追加しました"
      redirect_to goals_url
    else
      @goal = Goal.find(params[:goal_id])
      @bad_habit = BadHabit.new
      flash.now[:danger] = "習慣を追加できませんでした"
      render :new
    end
  end
  
  def destroy
    bad_habit = @goal.bad_habits.find_by(id: params[:id])
    bad_habit.destroy
    flash[:success] = '習慣を削除しました'
    redirect_back(fallback_location: goals_url)
  end
  
  private
  
  def bad_habit_params
    params.require(:bad_habit).permit(:name, :goal_id)
  end
end
