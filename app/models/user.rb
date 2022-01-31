class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable
  # Validaciones
  validates :username, :password, presence: true

  # Asosiaciones
  has_many :critics, dependent: :destroy

  enum role: { contributor: 0, admin: 1 }

  def self.from_omniauth(auth_hash)
    puts "********************************************"
    pp auth_hash
    puts "********************************************"
    where(provider: auth_hash.provider, uid: auth_hash.uid).first_or_create do |user|
      user.provider = auth_hash.provider
      user.username = auth_hash.info.nickname
      user.uid = auth_hash.uid
      user.email = auth_hash.info.email
      user.password = Devise.friendly_token[0, 20]
    end
  end
end
