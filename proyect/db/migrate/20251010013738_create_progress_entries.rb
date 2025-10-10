class CreateProgressEntries < ActiveRecord::Migration[8.0]
  def change
    create_table :progress_entries do |t|
      t.references :participation, null: false, foreign_key: true
      t.date    :logged_on, null: false
      t.decimal :quantity, precision: 10, scale: 2, null: false
      t.string  :note, limit: 255
      t.integer :points_awarded, null: false, default: 0
      t.timestamps
    end
  end
end
