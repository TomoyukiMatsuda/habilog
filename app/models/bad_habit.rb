class BadHabit < ApplicationRecord
  belongs_to :goal
  
  validates :name, presence: true, length: { maximum: 100 }
end
