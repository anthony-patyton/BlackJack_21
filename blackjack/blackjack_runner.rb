require_relative 'blackjack'
require 'pry'
require 'colorize'
require 'colorized_string'

SUITS = %w[Hearts Spades Clubs Diamonds]
RANKS = %w[2, 3, 4, 5, 6, 7, 8, 9, 10, Ace, Jack, Queen, King]

initial_amount = 500
game = Blackjack.new SUITS, RANKS, initial_amount

game.deal
puts game.show_hands
player_cards = game.player_hand.dealt_cards

while game.player_hand.get_value <= 21 do
  unless player_cards.first.rank == '10' && player_cards.last.rank == 'Ace' || 
  player_cards.first.rank == 'Ace' && player_cards.last.rank == '10'
    puts "Do you wnat to Hit(1) or Stand(2)?"
    res = gets.strip
    if res == '1'
      puts
      game.hit
      puts ColorizedString["Player Hand: " + game.player_hand.to_s].colorize(:light_green)
      puts ColorizedString["Dealer Hand: " + game.dealer_hand.to_s].colorize(:light_cyan)
    elsif res == '2'
      puts
      game.stand
      puts ColorizedString["Player Hand: " + game.player_hand.to_s].colorize(:light_green)
      puts ColorizedString["Dealer Hand: " + game.dealer_hand.to_s].colorize(:light_cyan)
      break
    end
  else
    game.stand
    puts ColorizedString["Player Hand: " + game.player_hand.to_s].colorize(:light_green)
    puts ColorizedString["Dealer Hand: " + game.dealer_hand.to_s].colorize(:light_cyan)
    break
  end
end

puts game.set_result
