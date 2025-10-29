class Badge < ApplicationRecord
  has_many :user_badges, dependent: :destroy

  validates :name, presence: true, length: { maximum: 100 }
  validates :code, presence: true,
                   uniqueness: { case_sensitive: false },
                   length: { maximum: 50 }
  validates :description, length: { maximum: 500 }, allow_blank: true
end

