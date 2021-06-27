class Spot < ApplicationRecord
  validates :address, presence: true
  belongs_to :user
  has_many :memories, dependent: :destroy
  validates :user_id, presence: true
  validates :address, presence: true
  default_scope -> { order(created_at: :desc) }
  paginates_per 10

  def to_latlng
    latlng = self.address.split(',')
    return [latlng[0].to_f, latlng[1].to_f ]
  end

  def to_lat
    latlng = self.address.split(',')
    return latlng[0].to_f
  end

  def to_lng
    latlng = self.address.split(',')
    return latlng[1].to_f
  end

  private

    
  
end
