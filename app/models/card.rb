class Card < ActiveRecord::Base
  belongs_to :game
  belongs_to :player, optional: true


  def assign_to_player(player_id)
    self.in_deck = false
    self.player_id = player_id
    self.save
  end

  def place_on_table
    self.in_deck = false
    self.save
  end

end
