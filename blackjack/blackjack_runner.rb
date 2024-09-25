require_relative 'blackjack'
require 'pry'
require 'colorize'
require 'colorized_string'

SUITS = %w[Hearts Spades Clubs Diamonds]
RANKS = %w[2, 3, 4, 5, 6, 7, 8, 9, 10, Ace, Jack, Queen, King]
MINIMUM_BETS = [15, 25, 50, 500, 1000, 2500, 500000]

puts "Enter how much $$$ you got! BALLER"
initial_amount = gets.strip.to_i 
@game = Blackjack.new SUITS, RANKS, initial_amount

puts "How many decks do you want to play with 6 or 8 or a certain amount. Leave it empty to play 8"
deck_count = gets.strip.to_i
if deck_count == 0
  @game.deck.eight_deck
elsif deck_count == 6
  @game.deck.six_deck
else
  @game.deck.add_deck(deck_count)
end

@game.deck.shuffle

def winner_winner_chicken_dinner
  puts "Would you like to increase bet? Leave empty for the same bet or minimum bet?"
  high_stakes = gets.strip.to_i
  if high_stakes == 0
    if high_stakes > 0 
      @game.wallet.bet = @game.wallet.history_bets.last
      puts "Same bet: #{@game.wallet.bet}"
    else
      @game.wallet.bet = MINIMUM_BETS.first
    end
  elsif high_stakes <= @game.wallet.amount
    @game.wallet.change_bet(high_stakes)
  else
    puts "Your bets too high!!! Or you're BROKE!!!".colorize(:red)
    winner_winner_chicken_dinner
  end
end

while @game.current_gamer == 'Player'
  winner_winner_chicken_dinner
  @game.deal
  puts @game.show_hands
  player_cards = @game.player_hand.dealt_cards

  while @game.player_hand.get_value <= 21 do
    puts "Do you want to Hit(1) or Stand(2)?"
    res = gets.strip
    if res == '1'
      puts
      @game.hit
      puts ColorizedString["Player Hand: " + @game.player_hand.to_s].colorize(:light_green)
      puts ColorizedString["Dealer Hand: " + @game.dealer_hand.to_s].colorize(:light_cyan)
    else res == '2'
      puts
      @game.stand
      puts ColorizedString["Player Hand: " + @game.player_hand.to_s].colorize(:light_green)
      puts ColorizedString["Dealer Hand: " + @game.dealer_hand.to_s].colorize(:light_cyan)
      break
    end
  end

  puts @game.set_result
  @game.play_again

end
