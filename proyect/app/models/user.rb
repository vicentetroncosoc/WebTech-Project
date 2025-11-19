class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :owned_challenges, class_name: "Challenge", foreign_key: :owner_id, dependent: :nullify
  has_many :participations, dependent: :destroy
  has_many :challenges, through: :participations
  has_many :user_badges, dependent: :destroy
  has_many :badges, through: :user_badges
  has_many :notifications, dependent: :destroy
  has_many :progress_entries, through: :participations


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


  def admin?
    role.to_s.downcase == "admin"
  end

  def creator?
    role.to_s.downcase == "creator"
  end

  def standard?
    !admin? && !creator?
  end
end
