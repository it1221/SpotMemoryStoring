class AddPrivateToSpots < ActiveRecord::Migration[6.1]
  def change
    add_column :spots, :private, :boolean, default: true
    add_index :spots, :private
  end
end
