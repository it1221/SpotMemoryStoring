class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :user_image, default: "default_image.jpg"
      t.text :introduction
      t.string :password_digest
      t.boolean :admin

      t.timestamps
    end
  end
end
