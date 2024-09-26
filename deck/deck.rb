require_relative '../card/card'

class Deck
  attr_reader :deck, :suits, :ranks
  SUITS = %w[Hearts Spades Clubs Diamonds]
  RANKS = %w[2 3 4 5 6 7 8 9 10 Ace Jack Queen King]

  def initialize suits, ranks
    @deck = []
    @suits = SUITS
    @ranks = RANKS
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
    added_decks = 0
    while added_decks < number_of_decks
      create_deck 
      added_decks += 1
    end
  end

  def six_deck
    5.times do
      create_deck
    end
  end
  
  def eight_deck
    7.times do
      create_deck
    end
  end

  def which_deck
    puts "How many decks do you want to play with 6 or 8 or a certain amount. Leave it empty to play 8"
    deck_count = gets.strip.to_i
    if deck_count == 0
      eight_deck
    elsif deck_count == 1
      puts "Playing one deck"
    elsif deck_count == 6
      six_deck
    else
      add_deck(deck_count)
    end
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
