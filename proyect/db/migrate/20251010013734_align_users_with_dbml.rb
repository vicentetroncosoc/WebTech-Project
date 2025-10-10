class AlignUsersWithDbml < ActiveRecord::Migration[8.0]
  def change
    change_table :users, bulk: true do |t|
      t.string :name
      t.string :email
      t.string :password_digest
      t.string :avatar_url
      t.text   :bio
    end
    add_index :users, :email, unique: true
  end
end