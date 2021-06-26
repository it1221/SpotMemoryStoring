class AddIndexToMemories < ActiveRecord::Migration[6.1]
  def change
    add_column :memories, :private, :boolean, default: true
    add_reference :memories, :user, foreign_key: true
    add_reference :memories, :spot, foreign_key: true
    add_index :memories, [:created_at, :user_id, :spot_id]    
  end
end
