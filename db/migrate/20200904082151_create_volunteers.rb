class CreateVolunteers < ActiveRecord::Migration[5.2]
  def change
    create_table :volunteers do |t|
      t.string :group_name
      t.string :date
      t.string :open_time
      t.string :venue
      t.string :title
      t.text :description
      t.string :image_id
      t.string :event_url
      t.integer :group_id
      t.timestamps
    end
  end
end
