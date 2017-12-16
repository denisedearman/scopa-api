class PlayerGame < ActiveRecord::Base
  belongs_to :player
  belongs_to :game
  has_many :cards

  def play_move(hand, table)
    if validate_move(hand, table)
      if !table
        cards.find_by_id(hand.keys[0]).place_on_table
      else
        cards.find_by_id(hand.keys[0]).capture(player.id, game.id)
        table.keys.each{|card_id| Card.find_by(id: card_id).capture(player.id, game.id)}
      end
    else
      false
    end
  end

  def validate_move(hand, table)
    verify_hand(hand) && verify_table(table) && valid_move(hand, table)
  end

  def verify_hand(hand)
    hand.each{|card_id| card_id && player.hand.find(id: card_id)}
  end

  def verify_table(table)
    if table
      table.each{|card_id| card_id && game.on_table.find(id: card_id)}
    else
      true
    end
  end

  def valid_move(hand, table)
    if hand.keys.length != 1
      false
    elsif !table
      true
    else
      card = Card.find_by(id: hand.keys[0])
      sum = 0
      table.each{|card_id| sum += Card.find_by(id: card_id).value}
      sum == card.value
    end
  end

end
