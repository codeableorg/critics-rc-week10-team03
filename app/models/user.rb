class User < ApplicationRecord
  validates :username, presence: true
  has_many :critics, dependent: :destroy

  enum role: { user: 0, admin: 1 }
end
