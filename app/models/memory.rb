class Memory < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true, length: {maximum: 200}
  belongs_to :user
  belongs_to :spot
  validates :user_id, presence: true
  validates :spot_id, presence: true
  default_scope -> { order(created_at: :desc) }
  paginates_per 10

  def get_spot_name
    spot = Spot.find_by(id: self.spot_id)
    return spot.name
  end

  def get_private
    if !!self.private
      return "非公開設定中"
    else
      return "公開中"
    end
  end
end
