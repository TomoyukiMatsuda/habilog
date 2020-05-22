class Goal < ApplicationRecord
  belongs_to :user
  has_many :good_habits
  has_many :bad_habits
  
  validates :name, presence: true, length: { maximum: 100 }
end
