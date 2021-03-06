class ToppagesController < ApplicationController
  skip_before_action :require_user_logged_in
  
  def index
    if logged_in?
      @good_log = GoodLog.new # form_with用
      @bad_log = BadLog.new # form_with用
      @goals = current_user.goals.order(id: :desc).page(params[:page]).per(5)
    end
  end
end
