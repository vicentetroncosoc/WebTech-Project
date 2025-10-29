class Participation < ApplicationRecord
  belongs_to :user
  belongs_to :challenge

  has_many :progress_entries, dependent: :destroy

  # Un usuario no puede estar dos veces en el mismo challenge
  validates :user_id, uniqueness: { scope: :challenge_id, message: "ya está participando en este challenge" }

  # Catálogos según reglas actuales
  VALID_ROLES  = %w[participant creator].freeze
  VALID_STATES = %w[pending active left banned].freeze

  validates :role,  inclusion: { in: VALID_ROLES }
  validates :state, inclusion: { in: VALID_STATES }

  # Puntos no negativos
  validates :total_points, numericality: { greater_than_or_equal_to: 0 }

  # Consistencia temporal
  validate :left_after_joined

  private

  def left_after_joined
    return if left_at.blank? || joined_at.blank?
    errors.add(:left_at, "debe ser posterior a la fecha de ingreso") if left_at < joined_at
  end
end