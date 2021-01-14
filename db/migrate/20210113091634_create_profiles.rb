class CreateProfiles < ActiveRecord::Migration[6.0]
  def change
    create_table :profiles do |t|
      t.integer :experience_id
      t.integer :part_id
      t.integer :frequency_id
      t.references :user
      t.string :introduction
      t.timestamps
    end
  end
end
