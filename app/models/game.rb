class Game < ActiveRecord::Base
  has_many :player_games
  has_many :players, through: :player_games
  has_many :cards



  def player_1=(player_1_name)
     player = Player.find_or_create_by(name: player_1_name)
     self.player_games << PlayerGame.new(player: player)
  end

  def player_2=(player_2_name)
    player = Player.find_or_create_by(name: player_2_name)
    self.player_games << PlayerGame.new(player: player)
  end

end
