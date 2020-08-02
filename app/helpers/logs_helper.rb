module LogsHelper
  
  # 引数logsに対して引数日dateのログが有るかどうかチェックし、あればtrue、なければfalseを返す
  def log?(date, logs)
    day = I18n.l date
    # logsの要素の作成日付を取得して新しい配列を作成
    log_days = logs.map { |log| log_day = I18n.l log.created_at }
    log_days.include?(day) #その日作成されたlogがあるかどうか確認
  end
  
  # 習慣登録日から何日目かを計算する
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

  # やるべき習慣連続日数の記録計算
  # 昨日のlogがない場合と昨日のlogのみの場合はfalseを返し、それ以外は連続日数の数値を返す
  def good_daily(logs)
    # 昨日のlogが有る場合のみ処理を実行
    if log?(Date.yesterday, logs)
      gap = 1
      n = 1
      record = 0 # recordは連続日数の数値
      while gap == 1 #gapが1のままであれば、連続で記録がある状態
        # logの最後から順番に作成日付を取得し、連続した記録が連日の記録かをチェックする
        log1 = Date.parse(I18n.l logs.last(n).first.created_at)
        log2 = Date.parse(I18n.l logs.last(n+=1).first.created_at)
        
        gap = (log1 - log2).to_i # log1とlog2のcreated_atの日付の差をgapに代入、1であれば連続記録
        record += 1 # 繰り返し処理が実行されるたびにrecordに1を加算していく
      end
      
      # logが昨日のみの場合(recordが1のとき)はfalseを返す
      if record != 1
        record
      end
    end
  end
  
  # やめるべき習慣やってない期間（連続日数）計算して返す
  def bad_daily(logs, habit)
    # 昨日と今日のlogが無い場合に実行
    if log?(Date.yesterday, logs) == false && log?(Date.current, logs) == false
      
      if logs.last # logがあれば実行し、なければdaysメソッドで登録日からの日数を返す
        today = Date.current
        last_log = Date.parse(I18n.l logs.last.created_at)
        record = (today - last_log).to_i # 今日日付から最後のlog作成日を差し引いた値を取得
      elsif days(habit) != 1
        days(habit)
      end
    end
  end
end