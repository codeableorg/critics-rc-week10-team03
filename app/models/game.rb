class Game < ApplicationRecord
  validates :name, :category, :rating, :cover, :release_date, presence: true
  validates :release_date, comparison: {less_than: Date.today}
  validate :validate_parent

  belongs_to :game
  has_and_belongs_to_many :platforms
  has_and_belongs_to_many :genres
  has_many :involved_companies, dependent: :destroy
  has_many :companies, through: :involved_companies
  has_many :critics, as: :criticable, dependent: :destroy
  has_one_attached :cover

  has_many :expansion, class_name: "Game", foreign_key: "parent_id", inverse_of: "parent",
                       dependent: destroy
  belongs_to :parent, class_name: "Game", inverse_of: "expansion", optional: true

  enum category: { main_game: 0, expansion: 1 }

  def validate_parent
    if category_id && category == "main_game"
      errors.add(:parent_id, "Parent_id should be null")
    elsif Game.find(category_id).nil? && category == "expansion"
      errors.add(:parent_id, "Game doesn't exist")
  end
end
