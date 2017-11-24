class Player < ActiveRecord::Base
  has_many :player_games
  has_many :games, through: :player_games
  has_many :cards
  validates :name, uniqueness: true, presence: true

end
