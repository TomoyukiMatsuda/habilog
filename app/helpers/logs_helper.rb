module LogsHelper
  
  # 習慣登録日からの何日目かを計算する
  def days(habit)
    today = Date.current
    day = Date.parse(I18n.l habit.created_at) # xxxx-xx-xxに変換して格納
    (today - day + 1).to_i
  end

  # good_logsレコードの数を取得
  def good_log_counts(good_habit)
    good_habit.good_logs.count
  end
  
  # bad_logsレコードの数を取得
  def bad_log_counts(bad_habit)
    (days(bad_habit) - bad_habit.bad_logs.count).to_i
  end
  
  # 引数ハビットに対して引数日のログが有るかどうかチェックする
  def log?(date, logs)
    day = I18n.l date
    
    log_days = []
    logs.each do |log|
      log_day = I18n.l log.created_at
      log_days.push(log_day)
    end
    log_days.include?(day)
  end

  # やるべき習慣連続日数の記録計算
  def good_daily(logs)
    # 昨日のlogが有る場合のみ処理を実行
    if log?(Date.yesterday, logs)
      gap = 1
      n = 1
      record = 0
      while gap == 1
        log1 = Date.parse(I18n.l logs.last(n).first.created_at)
        log2 = Date.parse(I18n.l logs.last(n+=1).first.created_at)
        
        gap = (log1 - log2).to_i
        record += 1
      end
      
      # logが昨日のみの場合はfalseを返す
      if record != 1
        return record
      end
    end
  end
  
  # やめるべき習慣連続で絶っている日数計算
  def bad_daily(logs, habit)
    # 昨日と今日のlogが無い場合に実行
    if log?(Date.yesterday, logs) == false && log?(Date.current, logs) == false
      
      if logs.last
        today = Date.current
        last_log = Date.parse(I18n.l logs.last.created_at)
        record = (today - last_log).to_i
        
        # logが無い(0)の場合はfalse
        if record != 0
          record
        end
      elsif days(habit) != 1
        days(habit)
      end
    end
  end
end
