class Game < ActiveRecord::Base
  has_many :player_games
  has_many :players, through: :player_games
  has_many :cards



  def players=(players_attributes)
    players_attributes.each do |player|
      player_game = PlayerGame.new
      player_game.game = self
      player_game.player = player
      player_game.save
    end
  end

end
