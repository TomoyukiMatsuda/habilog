class GoodLogsController < ApplicationController
  before_action :correct_create_user, only: :create
  before_action :correct_destroy_user, only: :destroy
  
  def create
    good_log = GoodLog.new(good_log_params)
    
    if good_log.save
      flash[:success] = 'やるべき習慣を達成！'
      redirect_back(fallback_location: root_url)
    else
      @good_log = GoodLog.new
      flash.now[:danger] = '習慣チェックに失敗しました'
      render 'toppages/index'
    end
  end
  
  def destroy
    good_log = GoodLog.find_by(id: params[:id])
    unfinished(good_log)
    flash[:warning] = '習慣の状態を元に戻しました'
    redirect_back(fallback_location: root_url)
  end
  
  private
  
  def good_log_params
    params.require(:good_log).permit(:log, :good_habit_id)
  end
  
  def correct_create_user
    good_habit = GoodHabit.find_by(id: params[:good_log][:good_habit_id])
    goal = current_user.goals.find_by(id: good_habit.goal_id)
    unless goal
      flash[:danger] = 'エラー'
      redirect_to root_url
    end
  end
  
  def correct_destroy_user
    good_log = GoodLog.find_by(id: params[:id])
    good_habit = good_log.good_habit
    goal = current_user.goals.find_by(id: good_habit.goal_id)
    unless goal
      flash[:danger] = 'エラー'
      redirect_to root_url
    end
  end
  
end
