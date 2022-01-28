class Company < ApplicationRecord
  # validaciones
  validates :name, presence: true, uniqueness: true

  # asosiaciones
  has_many :critics, as: :criticable, dependent: :destroy
  has_many :involved_companies, dependent: :destroy
  has_many :games, through: :involved_companies, counter_cache: true

  has_one_attached :cover
end
