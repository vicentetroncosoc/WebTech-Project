class Tag < ApplicationRecord
  has_many :challenge_tags, dependent: :destroy
  has_many :challenges, through: :challenge_tags

  validates :name, presence: true, uniqueness: true
end
