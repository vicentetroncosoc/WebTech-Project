class CreateParticipations < ActiveRecord::Migration[8.0]
  def change
    create_table :participations do |t|
  t.references :user, null: false, foreign_key: true
  t.references :challenge, null: false, foreign_key: true
  t.integer :points, default: 0, null: false
  t.string :status, default: "active", null: false
  t.timestamps
end
add_index :participations, [:user_id, :challenge_id], unique: true

  end
end
