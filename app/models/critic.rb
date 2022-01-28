class Critic < ApplicationRecord
  # validaciones
  validates :title, :body, presence: true
  belongs_to :user, counter_cache: true
  belongs_to :criticable, polymorphic: true, counter_cache: true
end
