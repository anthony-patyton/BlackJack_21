require_relative '../card/card'
require 'pry'

class Deck
  attr_reader :deck, :suits, :ranks
  SUITS = %w[Hearts Spades Clubs Diamonds]
  RANKS = %w[2 3 4 5 6 7 8 9 10 Ace Jack Queen King]

  def initialize suits, ranks
    @deck = []
    @suits = suits
    @ranks = ranks
    create_deck
  end  
	
  def shuffle
    @deck.shuffle!
  end

  def deal_card
    @deck.pop
  end

  def replace_with new_deck
    @suits = []
    @ranks = []
    @deck = new_deck
    
    new_deck.each do |card|
      add_suits_and_ranks(card)
    end
    self
  end

  def add_deck number_of_decks
    added_decks = create_deck * number_of_decks
  end

  private

  def create_deck
    suits.each do |suit|
      ranks.each do |rank|
        @deck.push(Card.new(suit, rank))
      end
    end
  end

  def add_suits_and_ranks card
    suit = card.suit
    rank = card.rank
    
    @suits.push(suit) unless @suits.include?(suit)
    @ranks.push(suit) unless @ranks.include?(rank) 
  end
end
