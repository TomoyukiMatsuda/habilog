class LogsController < ApplicationController
  before_action :require_user_logged_in
  
  def index
    @goals = current_user.goals.order(id: :desc).page(params[:page]).per(5)
  end
end