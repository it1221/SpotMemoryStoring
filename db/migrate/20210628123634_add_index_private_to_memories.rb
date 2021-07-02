class AddIndexPrivateToMemories < ActiveRecord::Migration[6.1]
  def change
    add_index :memories, :private
  end
end
