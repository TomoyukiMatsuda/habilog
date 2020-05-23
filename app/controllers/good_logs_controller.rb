class GoodLogsController < ApplicationController
  before_action :require_user_logged_in

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
    good_habit = GoodHabit.find(params[:id])
    good_logs = good_habit.good_logs
    unfinished(good_logs)
    flash[:warning] = '習慣の状態を元に戻しました'
    redirect_back(fallback_location: root_url)
  end
  
  private
  
  def good_log_params
    params.require(:good_log).permit(:log, :good_habit_id)
  end
end
