class Player < ActiveRecord::Base
  has_many :player_games
  has_many :games, through: :player_games
  has_many :cards, through: :player_games
  validates :name, uniqueness: true, presence: true


  def hand
    self.cards.select{|card| !card.captured}
  end

  def captures
    self.cards.select{|card| card.captured}
  end

end
