class MakeDifferenceToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :image_name, :string, default: "default_image"

    remove_column :users, :user_image, :string
  end
end
