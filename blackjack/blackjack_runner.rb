require_relative 'blackjack'
require 'pry'

SUITS = %w[Hearts Spades Clubs Diamonds]
RANKS = %w[2, 3, 4, 5, 6, 7, 8, 9, 10, Ace, Jack, Queen, King]

initial_amount = 500
game = Blackjack.new SUITS, RANKS, initial_amount

game.deal
puts game
