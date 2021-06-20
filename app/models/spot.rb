class Spot < ApplicationRecord
  validates :address, presence: true


  def address_to_latlng
    latlng = self.address.split(',')
    lat = latlng[0].to_f
    lng = latlng[1].to_f
  end

  private

    
  
end
