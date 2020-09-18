class CreateGroups < ActiveRecord::Migration[5.2]
  def change
    create_table :groups do |t|
      t.string :name
      t.string :active_area
      t.string :address
      t.string :mail
      t.string :phone_number
      t.text :description
      t.timestamps
      t.string :image_id
    end
    add_index :groups, :name, unique: true
  end
end
