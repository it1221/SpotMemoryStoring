class AddIndexToSpots < ActiveRecord::Migration[6.1]
  def change
    add_reference :spots, :user, foreign_key: true 
    add_index :spots, [:address, :user_id]
    remove_column :spots, :name, :string
    add_column :spots, :name, :string
    add_index :spots, :name
  end
end
