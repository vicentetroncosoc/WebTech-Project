class CreateChallengeTags < ActiveRecord::Migration[8.0]
  def change
    create_table :challenge_tags do |t|
  t.references :challenge, null: false, foreign_key: true
  t.references :tag, null: false, foreign_key: true
  t.timestamps
    end
    add_index :challenge_tags, [:challenge_id, :tag_id], unique: true
  end
end
