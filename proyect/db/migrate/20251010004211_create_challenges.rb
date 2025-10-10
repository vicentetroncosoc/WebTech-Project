class CreateChallenges < ActiveRecord::Migration[8.0]
  def change
    create_table :challenges do |t|
  t.string :title, null: false
  t.text :description
  t.date :starts_on, null: false
  t.date :ends_on, null: false
  t.references :created_by, null: false, foreign_key: { to_table: :users }
  t.timestamps  
    end
  add_index :challenges, :title, unique: true
  end
end
