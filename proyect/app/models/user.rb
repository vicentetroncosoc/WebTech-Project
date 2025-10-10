class User < ApplicationRecord
  has_secure_password

  has_many :owned_challenges, class_name: "Challenge", foreign_key: :owner_id, dependent: :nullify

  has_many :participations, dependent: :destroy
  has_many :challenges, through: :participations

  has_many :user_badges, dependent: :destroy
  has_many :badges, through: :user_badges

  has_many :notifications, dependent: :destroy

  validates :email, presence: true, uniqueness: true
  validates :password_digest, presence: true
end
