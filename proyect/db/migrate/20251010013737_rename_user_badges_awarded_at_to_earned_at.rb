class RenameUserBadgesAwardedAtToEarnedAt < ActiveRecord::Migration[8.0]
  def change
    if column_exists?(:user_badges, :awarded_at)
      rename_column :user_badges, :awarded_at, :earned_at
    end
  end
end
