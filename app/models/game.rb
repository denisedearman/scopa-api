class Game < ActiveRecord::Base
  has_many :player_games
  has_many :players, through: :player_games
  has_many :cards


  def award_points
    player_1_count = player_games[0].cards.length
    player_2_count = player_games[1].cards.length
    if player_1_count != player_2_count
      player_1_count > player_2_count ? player_games[0].award_point : player_games[1].award_point
    end
    player_1_count = player_games[0].get_coin_count
    player_2_count = player_games[1].get_coin_count
    if  player_1_count != player_2_count
      player_1_count > player_2_count ? player_games[0].award_point : player_games[1].award_point
    end
    if player_games[0].has_sette_bello
      player_games[0].award_point
    elsif player_games[1].has_sette_bello
      player_games[1].award_point
    end
    player_1_count = player_games[0].prime_score
    player_2_count = player_games[1].prime_score
    if player_1_count != player_2_count
      player_1_count > player_2_count ? player_games[0].award_point : player_games[1].award_point
    end

    player_games.each {|player| player.award_scopa_points}
  end

  def deck
    self.cards.select{|card| card.in_deck}
  end

  def on_table
    self.cards.select{|card| !card.in_deck && !card.player_game_id}
  end

  def get_current_player
    if(self.players[0].hand.length == 0 && self.players[1].hand.length == 0)
      self.deal
    end
    self.players[0].hand.length >= self.players[1].hand.length ? self.players[0] : self.players[1]
  end

  def is_end_game?
    deck.length == 0 && self.cards.length != 0 && self.players[0].hand.length == 0 && self.players[1].hand.length == 0
  end

  def deal
    if self.deck.length == 40
      for i in 0..3
        card_index = rand(0..self.deck.length-1)
        self.deck[card_index].place_on_table
      end
    end
    if self.deck.length >=6
      for i in 0..1
        for j in 0..2
          card_index = rand(0..self.deck.length-1)
          card = self.deck[card_index]
          card.assign_to_player(self.player_games[i].id)
        end
      end
    end
  end

  def player_with_most_cards
    player_1_count = player_games[0].cards.length
    player_2_count = player_games[1].cards.length
    if player_1_count != player_2_count
      player_1_count > player_2_count ? player_games[0].player.name : player_games[1].player.name
    else
      "draw"
    end
  end

  def player_with_most_coins
    player_1_count = player_games[0].get_coin_count
    player_2_count = player_games[1].get_coin_count
    if player_1_count != player_2_count
      player_1_count > player_2_count ? player_games[0].player.name : player_games[1].player.name
    else
      "draw"
    end
  end

  def prime_winner
    player_1_count = player_games[0].prime_score
    player_2_count = player_games[1].prime_score
    if player_1_count != player_2_count
      player_1_count > player_2_count ? player_games[0].player.name : player_games[1].player.name
    end
  end

  def sette_bello
    if player_games[0].has_sette_bello
      player_games[0].player.name
    elsif player_games[1].has_sette_bello
      player_games[1].player.name
    else
      "draw"
    end
  end

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
