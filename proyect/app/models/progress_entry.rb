class ProgressEntry < ApplicationRecord
  belongs_to :participation
  delegate :challenge, to: :participation

  validates :logged_on, presence: true
  validates :quantity,
            presence: true,
            numericality: { greater_than_or_equal_to: 0 }
  validates :points_awarded,
            presence: true,
            numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  validate :logged_on_within_challenge

  after_commit :recalculate_total_points, on: [:create, :update, :destroy]

  private

  def recalculate_total_points
    # Buscar la participation fresca en la BD.
    # Si ya no existe (por ejemplo, al salir del challenge), no hacemos nada.
    participation_record = Participation.find_by(id: participation_id)
    return unless participation_record

    new_total = participation_record.progress_entries.sum(:points_awarded)

    # update_column evita callbacks infinitos
    participation_record.update_column(:total_points, new_total)
  end

  def logged_on_within_challenge
    return unless challenge && logged_on

    if logged_on < challenge.start_date || logged_on > challenge.end_date
      errors.add(
        :logged_on,
        "must be within challenge dates (#{challenge.start_date}–#{challenge.end_date})"
      )
    end
  end
end