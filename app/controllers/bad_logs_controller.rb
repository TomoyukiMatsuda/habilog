class BadLogsController < ApplicationController
  before_action :require_user_logged_in
  
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
    bad_habit = BadHabit.find(params[:id])
    bad_logs = bad_habit.bad_logs
    unfinished(bad_logs)
    flash[:success] = '習慣の状態を元に戻しました'
    redirect_back(fallback_location: root_url)
  end
  
  private
  
  def bad_log_params
    params.require(:bad_log).permit(:log, :bad_habit_id)
  end
end
