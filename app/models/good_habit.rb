class GoodHabit < ApplicationRecord
  belongs_to :goal
  has_many :good_logs
  
  validates :name, presence: true, length: { maximum: 100 }
  
  # その日に習慣完了済み未済み判定メソッド
  def finished?
    # 当日日付のlogがあればtrue,なければfalse
    today = I18n.l Date.today
    
    log_days = []
    self.good_logs.each do |good_log|
      log_day = I18n.l good_log.created_at
      log_days.push(log_day)
    end
    log_days.include?(today)
  end
  
  # 今日完了済みのlogがあれば消去するメソッド コントローラに書いた方が良い？
  def unfinished
    today = I18n.l Date.today
    good_log = self.good_logs.last
    good_log_day = I18n.l good_log.created_at
    good_log.destroy if today == good_log_day
  end

end
