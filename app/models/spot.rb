class Spot < ApplicationRecord
  validates :address, presence: true
  belongs_to :user
  has_many :memories, dependent: :destroy
  validates :user_id, presence: true
  validates :address, presence: true


  def to_latlng
    latlng = self.address.split(',')
    return { lat: latlng[0].to_f, lng: latlng[1].to_f }
  end

  private

    
  
end
