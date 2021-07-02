class Spot < ApplicationRecord
  validates :address, presence: true
  validates :name, presence: true
  belongs_to :user
  has_many :memories, dependent: :destroy
  validates :user_id, presence: true
  validates :address, presence: true
  default_scope -> { order(created_at: :desc) }
  paginates_per 10

  def to_latlng
    latlng = self.address.split(',')
    return {lat: latlng[0].to_f, lng: latlng[1].to_f }
  end

  def to_lat
    latlng = self.address.split(',')
    return latlng[0].to_f
  end

  def to_lng
    latlng = self.address.split(',')
    return latlng[1].to_f
  end

  def memories_latlng_to_js
    spots = Spot.where(user_id: self.user_id)
    s_latlng = []
    spots.each do |s|
      s_latlng.push(s.to_latlng)
    end
    return s_latlng
  end

  private

    
  
end
