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

  def cards=(cards)
    if (cards.length == 0)
      suits = ['cups', 'coins', 'swords', 'clubs']
      for i in 0..3
        self.cards << Card.new(suit: suits[i], value: 1, points: 16, in_deck: true, captured: false)
        self.cards << Card.new(suit: suits[i], value: 2, points: 12, in_deck: true, captured: false)
        self.cards << Card.new(suit: suits[i], value: 3, points: 13, in_deck: true, captured: false)
        self.cards << Card.new(suit: suits[i], value: 4, points: 14, in_deck: true, captured: false)
        self.cards << Card.new(suit: suits[i], value: 5, points: 15, in_deck: true, captured: false)
        self.cards << Card.new(suit: suits[i], value: 6, points: 18, in_deck: true, captured: false)
        self.cards << Card.new(suit: suits[i], value: 7, points: 21, in_deck: true, captured: false)
        self.cards << Card.new(suit: suits[i], value: 8, points: 10, in_deck: true, captured: false)
        self.cards << Card.new(suit: suits[i], value: 9, points: 10, in_deck: true, captured: false)
        self.cards << Card.new(suit: suits[i], value: 10, points: 10, in_deck: true, captured: false)
      end
    end
  end

end
