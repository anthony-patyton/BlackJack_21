require_relative 'deck'
require 'pry'

SUITS = %w[Hearts Spades Clubs Diamonds]
RANKS = %w[2 3 4 5 6 7 8 9 10 Ace Jack Queen King]

deck = Deck.new(SUITS, RANKS)

# puts deck
# puts deck.deck
# puts deck.suits
# puts deck.ranks

puts '--------inital deck-------'
puts deck.deck
puts "----Added 2 decks-------"
deck.add_deck(2)
puts deck.deck

puts "--------Dealt Card--------"
puts deck.deal_card

puts "-------New Deck-----------"
new_deck = []
new_deck.push(Card.new("Hearts", "8"))
new_deck.push(Card.new("Hearts", "9"))
new_deck.push(Card.new("Hearts", "10"))
puts new_deck.class
puts new_deck

puts "--------Deck has Been Replaced----------"
deck.replace_with(new_deck)
puts deck.deck
puts deck.shuffle
puts deck.deal_card
puts deck.class #notice how the deck is replaced with an Array object to Deck
