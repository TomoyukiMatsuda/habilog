class User < ApplicationRecord
  validates :name, presence: true, length: { maximum: 50 }
  validates :age, length: { maximum: 3 }
  validates :profile, length: { maximum: 255 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }

  has_many :goals
end
