class LogsController < ApplicationController
  def index
    @goals = current_user.goals.order(id: :desc).page(params[:page]).per(5)
    
    # log確認用↓↓
    @good_logs= GoodLog.all
  end
end
