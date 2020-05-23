class BadHabit < ApplicationRecord
  belongs_to :goal
  has_many :bad_logs, dependent: :destroy
  
  validates :name, presence: true, length: { maximum: 100 }
end
