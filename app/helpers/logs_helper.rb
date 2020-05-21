module LogsHelper
  
  def counts(habit)
    # good_logsレコードの数を取得
    @count_good_logs = habit.good_logs.count
  end
  
  # 引数ハビットに対して引数日のログが有るかどうかチェックする
  def log?(date, habit)
    day = I18n.l date
    
    log_days = []
    habit.good_logs.each do |good_log|
      log_day = I18n.l good_log.created_at
      log_days.push(log_day)
    end
    log_days.include?(day)
  end

  
  # 習慣連続日数の記録計算処理を行う
  def daily(habit)
    # 昨日のlogが有る場合のみ処理を実行
    if log?(Date.yesterday, habit)
      gap = 1
      n = 1
      @record = 0
      while gap == 1
        log1 = Date.parse(I18n.l habit.good_logs.last(n).first.created_at)
        log2 = Date.parse(I18n.l habit.good_logs.last(n+=1).first.created_at)
        
        gap = (log1 - log2).to_i
        @record += 1
      end
      
      # logが昨日のみの場合以外は@recordを返す
      unless @record == 1
        return @record
      end
    end
  end
  
end
