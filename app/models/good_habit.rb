class GoodHabit < ApplicationRecord
  belongs_to :goal
  has_many :good_logs
  
  validates :name, presence: true, length: { maximum: 100 }
  
  # コントローラに書いた方が良い？
  # 今日完了済みの習慣を元に戻す(未済み)メソッド
  def unfinished
    today = I18n.l Date.current
    good_log = self.good_logs.last
    good_log_day = I18n.l good_log.created_at
    good_log.destroy if today == good_log_day
  end
  
  # 習慣登録日からの何日目かを計算する
  def days
    day = Date.parse(I18n.l self.created_at) # xxxx-xx-xxに変換して格納
    today = Date.current
    (today - day + 1).to_i
  end
end
