class Goal < ApplicationRecord
  belongs_to :user
  has_many :good_habits, dependent: :destroy
  has_many :bad_habits, dependent: :destroy
  
  validates :name, presence: true, length: { maximum: 100 }
end
