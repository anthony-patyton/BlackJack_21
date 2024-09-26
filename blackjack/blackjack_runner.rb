require_relative 'blackjack'
require 'pry'
require 'colorize'
require 'colorized_string'

SUITS = %w[Hearts Spades Clubs Diamonds]
RANKS = %w[2, 3, 4, 5, 6, 7, 8, 9, 10, Ace, Jack, Queen, King]
MINIMUM_BETS = 20
INITIAL_AMOUNT = 500

puts "Enter how much $$$ you got! BALLER"
initial_amount = gets.strip.to_i
@game = Blackjack.new SUITS, RANKS, initial_amount

@game.deck.which_deck
@game.deck.shuffle

while @game.current_gamer == 'Player'
  def check_player_hands
    values_of_ten = %w[10 Jack Queen King]
    first_card_ace = @game.player_hand.dealt_cards.first.rank
    second_card_ten = @game.player_hand.dealt_cards.last.rank
    first_card_ten = @game.player_hand.dealt_cards.first.rank
    second_card_ace = @game.player_hand.dealt_cards.last.rank
    if first_card_ace.include?('Ace') && values_of_ten.include?(second_card_ten) || values_of_ten.include?(first_card_ten) && second_card_ace.include?('Ace')
      true
    else
      false
    end
  end
  @game.wallet.winner_winner_chicken_dinner
  @game.deal
  puts @game.show_hands

  while @game.player_hand.get_value <= 21 do
    if check_player_hands
      #got a blackjack
      @game.stand
      puts ColorizedString["Player Hand: " + @game.player_hand.to_s].colorize(:light_green)
      puts ColorizedString["Dealer Hand: " + @game.dealer_hand.to_s].colorize(:light_cyan)
      break
    else
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
  end

  puts @game.set_result
  @game.play_again

end
