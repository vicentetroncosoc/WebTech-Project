class ProgressEntry < ApplicationRecord
  belongs_to :participation
  validates :logged_on, :quantity, :points_awarded, presence: true
end
