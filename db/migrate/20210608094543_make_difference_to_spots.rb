class MakeDifferenceToSpots < ActiveRecord::Migration[6.1]
  def change
    drop_table :spots    
  end
end
