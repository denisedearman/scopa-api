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
    self.save
  end

end
