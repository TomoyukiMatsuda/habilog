module LogsHelper
  
  def counts(habit)
    # good_logsレコードの数を取得
    @count_good_logs = habit.good_logs.count
  end
  
  # 習慣連続日数の記録計算処理を行う
  def daily(habit)
    @record = 1
    loop{
      n = 1
      n_log = Date.parse(I18n.l habit.good_logs.last(n).first.created_at)
      s_log = Date.parse(I18n.l habit.good_logs.last(n+=1).first.created_at)
      
      gap = (n_log - s_log).to_i
      
      if gap == 1
        return @record += 1
      else
        break
      end
    }
  end
end
