class CreateBadges < ActiveRecord::Migration[8.0]
  def change
    create_table :badges do |t|
  t.string :name, null: false
  t.string :code, null: false
  t.text :description
  t.timestamps
  end
  add_index :badges, :code, unique: true

  end
end
