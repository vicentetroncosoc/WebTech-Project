class CreateNotifications < ActiveRecord::Migration[8.0]
  def change
    create_table :notifications do |t|
      t.references :user, null: false, foreign_key: true
      t.string  :title, limit: 120
      t.string  :body,  limit: 255
      t.datetime :read_at
      t.string  :notifiable_type
      t.bigint  :notifiable_id
      t.timestamps
    end
    add_index :notifications, [:notifiable_type, :notifiable_id]
  end
end