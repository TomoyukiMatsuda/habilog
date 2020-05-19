class GoodLogsController < ApplicationController
  
  def create
    good_log = GoodLog.new(good_log_params)
    
    if good_log.save
      flash[:success] = '習慣を完了しました'
      redirect_back(fallback_location: root_url)
    else
      @good_log = GoodLog.new
      flash.now[:danger] = '習慣チェックに失敗しました'
      render 'toppages/index'
    end
  end
  
  def destroy
    good_habit = GoodHabit.find(params[:id])
    good_habit.unfinished
    flash[:success] = '習慣を未完了に変更しました'
    redirect_back(fallback_location: root_url)
  end
  
  private
  
  def good_log_params
    params.require(:good_log).permit(:log, :good_habit_id)
  end
end
