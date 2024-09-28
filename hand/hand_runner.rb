require_relative '../card/card'
require_relative 'hand'
require 'pry'

hand = Hand.new

puts "Players Hand:"
hand.add_card(Card.new('Clubs', '8'))
hand.add_card(Card.new('Hearts', '8'))

puts "Dealers Hand:"
dealer_hand = Hand.new
dealer_hand.add_card(Card.new('Hearts', 'Ace'))
dealer_hand.add_card(Card.new('Hearts', '7'))

puts dealer_hand
