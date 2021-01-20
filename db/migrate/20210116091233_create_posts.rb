class CreatePosts < ActiveRecord::Migration[6.0]
  def change
    create_table :posts do |t|
      t.string :text, null: false
      t.references :user,        null: false ,foreign_key: true
      t.integer :part_id,        null: false
      t.integer :equipment_id,   null: false
      t.integer :place_id,       null: false
      
      t.timestamps
    end
  end
end
