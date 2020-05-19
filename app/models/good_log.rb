class GoodLog < ApplicationRecord
  belongs_to :good_habit
  
  validates :log, presence: true
end
