class User < ApplicationRecord
  # Validaciones
  validates :username, :role, presence: true

  # Asosiaciones
  has_many :critics, dependent: :destroy

  enum role: { user: 0, admin: 1 }
end
