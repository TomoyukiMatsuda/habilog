class GoodHabit < ApplicationRecord
  belongs_to :goal
  has_many :good_logs
  
  validates :name, presence: true, length: { maximum: 100 }
end
