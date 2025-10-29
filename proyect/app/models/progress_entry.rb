class ProgressEntry < ApplicationRecord
  belongs_to :participation
  delegate :challenge, to: :participation

  validates :logged_on, presence: true
  validates :quantity,  presence: true,
                        numericality: { greater_than_or_equal_to: 0 }
  validates :points_awarded, presence: true,
                             numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  validate :logged_on_within_challenge

  private

  def logged_on_within_challenge
    return unless challenge && logged_on
    if logged_on < challenge.start_date || logged_on > challenge.end_date
      errors.add(:logged_on, "must be within challenge dates (#{challenge.start_date}–#{challenge.end_date})")
    end
  end
end
