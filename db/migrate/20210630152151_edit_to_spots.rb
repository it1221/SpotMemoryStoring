class EditToSpots < ActiveRecord::Migration[6.1]
  def change
    remove_column :spots, :name, :string
    add_column :spots, :name, :string
  end
end
