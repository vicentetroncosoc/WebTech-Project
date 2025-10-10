class AlignChallengesWithDbml < ActiveRecord::Migration[8.0]
  def change
    change_table :challenges, bulk: true do |t|
      t.rename :created_by_id, :owner_id
      t.rename :title, :name
      t.rename :starts_on, :start_date
      t.rename :ends_on,   :end_date

      t.string  :category
      t.string  :frequency, null: false, default: "daily"
      t.integer :points_per_entry, null: false, default: 1
      t.integer :max_entries_per_period, null: false, default: 1
      t.boolean :is_approval_required, null: false, default: false
      t.string  :status, null: false, default: "draft"
    end

    # index opcional en owner_id ya existe por FK, el unique en name lo puedes mantener
    remove_index :challenges, :name if index_exists?(:challenges, :name)
    add_index :challenges, :name, unique: true
  end
end