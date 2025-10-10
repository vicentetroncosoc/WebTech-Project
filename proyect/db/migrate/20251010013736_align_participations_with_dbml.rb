class AlignParticipationsWithDbml < ActiveRecord::Migration[8.0]
  def change
    change_table :participations, bulk: true do |t|
      # Reemplazar los actuales
      t.remove :points if column_exists?(:participations, :points)
      t.remove :status if column_exists?(:participations, :status)

      t.string  :role, null: false, default: "participant"
      t.string  :state, null: false, default: "active"
      t.integer :total_points, null: false, default: 0
      t.datetime :joined_at, null: false, default: -> { "CURRENT_TIMESTAMP" }
      t.datetime :left_at
    end
  end
end
