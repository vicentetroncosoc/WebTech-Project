class ChallengeTag < ApplicationRecord
  belongs_to :challenge
  belongs_to :tag

  validates :challenge_id, uniqueness: { scope: :tag_id }
end

