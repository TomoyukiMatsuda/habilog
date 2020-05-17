class GoodHabitsController < ApplicationController
  
  def new
    @goal = Goal.find(params[:goal_id])
    @good_habit = GoodHabit.new
  end

  def create
    @good_habit = GoodHabit.new(good_habit_params)
    
    if @good_habit.save
      flash[:success] = "習慣を追加しました"
      redirect_to goals_url
    else
      @goal = Goal.find(params[:goal_id])
      @good_habit = GoodHabit.new
      flash.now[:danger] = "習慣の追加に失敗しました"
      render :new
    end
  end

  def destroy
    @good_habit = GoodHabit.find(params[:id])
    @good_habit.destroy
    flash[:success] = '習慣を削除しました'
    redirect_back(fallback_location: goals_url)
  end
  
  private
  
  def good_habit_params
    params.require(:good_habit).permit(:name).merge(goal_id: params[:goal_id])
  end
  
end
