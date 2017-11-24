class Game < ActiveRecord::Base
  has_many :player_games
  has_many :players, through: :player_games
  has_many :cards

end
