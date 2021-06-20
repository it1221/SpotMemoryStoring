class User < ApplicationRecord
  has_many :memory
  has_many :spot

  validates :name, uniqueness: true, length: { minimum: 3, maximum: 24 }
  validates :email, presence: true, uniqueness: true
  validates :password, length: { minimum: 8, maximum: 32 }

  has_secure_password

end