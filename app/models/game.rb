class Game < ApplicationRecord
  # validates :name, :cover, presence: true
  validates :rating, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 100,
                                     allow_nil: true }
  # validates :release_date, comparison: { less_than_or_equal_to: Time.zone.today }
  validate :validate_parent

  # belongs_to :game
  has_and_belongs_to_many :platforms
  has_and_belongs_to_many :genres
  has_many :involved_companies, dependent: :destroy
  has_many :companies, through: :involved_companies
  has_one_attached :cover

  has_many :expansions, class_name: "Game", foreign_key: "parent_id", dependent: :destroy,
                        inverse_of: "parent"

  belongs_to :parent, class_name: "Game", optional: true

  enum category: { main_game: 0, expansion: 1 }

  def validate_parent
    if parent_id && category == "main_game"
      errors.add(:parent_id, "Parent_id should be null")
    elsif Game.find_by(id: parent_id).nil? && category == "expansion"
      errors.add(:parent_id, "Game doesn't exist")
    end
  end
end
