class ToppagesController < ApplicationController
  
  def index
    @goals = current_user.goals.order(id: :desc).page(params[:page]).per(5)
    @good_log = GoodLog.new
  end
end
