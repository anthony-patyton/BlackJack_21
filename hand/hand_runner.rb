require_relative '../card/card'
require_relative 'hand'

hand = Hand.new

puts "Players Hand:"
hand.add_card(Card.new('Hearts', '8'))
hand.add_card(Card.new('Hearts', '9'))
puts hand

puts "Dealers Hand:"
hand2 = Hand.new
hand2.add_card(Card.new('Hearts', 'Ace'))
hand2.add_card(Card.new('Hearts', '7'))
puts hand2
