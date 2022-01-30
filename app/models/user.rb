class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  # Validaciones
  validates :username, presence: true

  # Asosiaciones
  has_many :critics, dependent: :destroy

  enum role: { contributor: 0, admin: 1 }
end
