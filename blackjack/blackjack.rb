require_relative '../deck/deck'

class Blackjack

  attr_reader :player_hand, :dealer_hand, :deck, :playing
  attr_accessor :current_gamer, :bet_amount

  def initialize suits, ranks
    @player_hand = nil
    @dealer_hand = nil
    @deck = Deck.new suits, ranks
    @deck.shuffle
    @playing = false
    @current_gamer = ''
  end

  def deal
  end
  
  def hit
  end

  def stand
  end

  def show_hands
  end

  def set_result
  end
end
