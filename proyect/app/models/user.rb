class User < ApplicationRecord
  has_secure_password

  has_many :owned_challenges, class_name: "Challenge", foreign_key: :owner_id, dependent: :nullify
  has_many :participations, dependent: :destroy
  has_many :challenges, through: :participations
  has_many :user_badges, dependent: :destroy
  has_many :badges, through: :user_badges
  has_many :notifications, dependent: :destroy

  # Validaciones para CRUD
  validates :username, presence: true,
                       uniqueness: { case_sensitive: false },
                       length: { maximum: 50 }
  validates :email,    presence: true,
                       uniqueness: { case_sensitive: false },
                       length: { maximum: 120 }
  validates :name,     length: { maximum: 120 }, allow_blank: true
  validates :role,     length: { maximum: 50 },  allow_blank: true
  validates :avatar_url, length: { maximum: 255 }, allow_blank: true
  validates :bio, length: { maximum: 1000 }, allow_blank: true

  # Password:
  # - requerido SOLO al crear
  # - opcional al editar (allow_nil)
  validates :password, length: { minimum: 6 }, allow_nil: true
end
