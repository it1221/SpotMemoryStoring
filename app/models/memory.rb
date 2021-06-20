class Memory < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true, length: {maximum: 200}
  
  
end
