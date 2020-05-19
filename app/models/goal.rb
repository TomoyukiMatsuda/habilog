class Goal < ApplicationRecord
  belongs_to :user
  has_many :good_habits
  
  validates :name, presence: true, length: { maximum: 100 }
end
