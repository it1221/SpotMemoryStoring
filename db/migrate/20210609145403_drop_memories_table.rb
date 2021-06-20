class DropMemoriesTable < ActiveRecord::Migration[6.1]
  def change
    drop_table :memories
  end
end
