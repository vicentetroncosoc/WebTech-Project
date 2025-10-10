class Challenge < ApplicationRecord
  belongs_to :owner, class_name: "User"

  has_many :participations, dependent: :destroy
  has_many :participants, through: :participations, source: :user

  has_many :challenge_tags, dependent: :destroy
  has_many :tags, through: :challenge_tags

  validates :name, presence: true, uniqueness: true
  validates :start_date, :end_date, presence: true
  validates :frequency, inclusion: { in: %w[daily weekly] }
  validates :status, inclusion: { in: %w[draft active finished paused] }

  validate :end_after_start
  def end_after_start
    errors.add(:end_date, "must be after start_date") if start_date && end_date && end_date < start_date
  end
end
