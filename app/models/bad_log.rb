class BadLog < ApplicationRecord
  belongs_to :bad_habit
  
  validates :log, presence: true
end
