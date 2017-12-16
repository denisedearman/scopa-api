class Card < ActiveRecord::Base
  belongs_to :game
  belongs_to :player_game, optional: true


  def assign_to_player(player_game_id)
    self.in_deck = false
    self.player_game_id = player_game_id
    self.save
  end

  def place_on_table
    self.in_deck = false
    self.player_game = nil
    self.save
  end

  def capture(player_id, game_id)
    self.in_deck = false
    self.captured = true
    self.player_game = PlayerGame.find_by(player_id: player_id, game_id: game_id)
    self.save
  end

end
