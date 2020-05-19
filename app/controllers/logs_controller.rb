class LogsController < ApplicationController
  def index
    @good_logs = GoodLog.order(id: :desc)
  end
end
