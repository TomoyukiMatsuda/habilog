class BadLogsController < ApplicationController
  before_action :correct_create_user, only: :create
  before_action :correct_destroy_user, only: :destroy

  def create
    bad_log = BadLog.new(bad_log_params)
    
    if bad_log.save
      flash[:warning] = 'やめるべき習慣をやってしまいました…'
      redirect_back(fallback_location: root_url)
    else
      @bad_log = BadLog.new
      flash.now[:danger] = '習慣チェックに失敗しました'
      render 'toppages/index'
    end
  end
  
  def destroy
    bad_log = BadLog.find_by(id: params[:id])
    unfinished(bad_log)
    flash[:success] = '習慣の状態を元に戻しました'
    redirect_back(fallback_location: root_url)
  end
  
  private
  
  def bad_log_params
    params.require(:bad_log).permit(:log, :bad_habit_id)
  end
  
  def correct_create_user
    bad_habit = BadHabit.find_by(id: params[:bad_log][:bad_habit_id])
    goal = current_user.goals.find_by(id: bad_habit.goal_id)
    unless goal
      flash[:danger] = 'エラー'
      redirect_to root_url
    end
  end
  
  def correct_destroy_user
    bad_log = BadLog.find_by(id: params[:id])
    bad_habit = bad_log.bad_habit
    goal = current_user.goals.find_by(id: bad_habit.goal_id)
    unless goal
      flash[:danger] = 'エラー'
      redirect_to root_url
    end
  end
end
