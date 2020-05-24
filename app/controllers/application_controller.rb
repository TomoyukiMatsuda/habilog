class ApplicationController < ActionController::Base
  before_action :require_user_logged_in
  
  include SessionsHelper
  
  private
  
  def require_user_logged_in
    unless logged_in?
      flash[:danger] = 'ログインしてください'
      redirect_to login_url
    end
  end
  
  # 習慣登録、削除の操作をログインユーザのみに限定
  def habit_correct_user
    @goal = current_user.goals.find_by(id: params[:goal_id])
    unless @goal
      flash[:danger] = 'エラー'
      redirect_to root_url
    end
  end
  
  # 今日完了済みの習慣の状態を元に戻す(logを削除)
  def unfinished(log)
    today = I18n.l Date.current
    log_day = I18n.l log.created_at
    log.destroy if today == log_day
  end
end
