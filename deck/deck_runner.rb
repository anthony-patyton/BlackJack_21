require_relative 'deck'

SUITS = %w[Hearts Spades Clubs Diamonds]
RANKS = %w[2 3 4 5 6 7 8 9 10 Ace Jack Queen King]

deck = Deck.new(SUITS, RANKS)

# puts deck
# puts deck.deck
# puts deck.suits
# puts deck.ranks

# puts "-" * 10 + "Shuffled deck".upcase + "-"*10
# deck.shuffle
# puts deck.deck

puts deck.deal_card

new_deck = []
new_deck.push(Card.new("Hearts", "8"))
new_deck.push(Card.new("Hearts", "9"))
new_deck.push(Card.new("Hearts", "10"))

puts new_deck

deck.add_deck(2)
