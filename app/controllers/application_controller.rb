class ApplicationController < ActionController::Base
  
  include SessionsHelper
  
  private
  
  def require_user_logged_in
    unless logged_in?
      flash[:danger] = 'ログインしてください'
      redirect_to login_url
    end
  end
  
  # 今日完了済みの習慣の状態を元に戻す(記録を削除)
  def unfinished(logs)
    today = I18n.l Date.current
    log = logs.last
    log_day = I18n.l log.created_at
    log.destroy if today == log_day
  end
end
