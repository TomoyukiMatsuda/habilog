class ToppagesController < ApplicationController
  
  def index
    if logged_in?
      @good_log = GoodLog.new # form_with用
      @goals = current_user.goals.order(id: :desc).page(params[:page]).per(5)
    end
  end
end
