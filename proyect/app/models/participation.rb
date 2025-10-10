class Participation < ApplicationRecord
  belongs_to :user
  belongs_to :challenge

  has_many :progress_entries, dependent: :destroy

  validates :user_id, uniqueness: { scope: :challenge_id }
  validates :role, inclusion: { in: %w[participant creator] }
  validates :state, inclusion: { in: %w[pending active left banned] }
end

