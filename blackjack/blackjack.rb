require_relative '../deck/deck'
require_relative '../hand/hand'
require_relative '../wallet/wallet'
require 'colorize'
require 'colorized_string'
require 'pry'

class Blackjack

  attr_reader :player_hand, :dealer_hand, :deck, :playing, :initial_amount 
  attr_accessor :current_gamer, :change_bet, :bet, :wallet, :result, :create_deck
  MINIMUM_BETS = 20

  def initialize suits, ranks, initial_amount
    @player_hand = nil
    @dealer_hand = nil
    @deck = Deck.new suits, ranks
    @wallet = Wallet.new initial_amount 
    @deck.shuffle
    @playing = false
    @current_gamer = 'Player'
    @result = ''
  end
 
  def deal
    if @wallet.bet == nil
      @wallet.bet = MINIMUM_BETS
    elsif @wallet.amount < 0
      puts "Your Broke" 
      exit
    end
    @wallet.subtract_from_wallet(@wallet.bet)
    @dealer_hand = Hand.new
    @player_hand = Hand.new

    2.times do
      @dealer_hand.add_card(@deck.deal_card)
      @player_hand.add_card(@deck.deal_card)
    end
    @dealer_hand.dealt_cards.first.show = false
    @playing = true
    player_cards = @player_hand.dealt_cards
    values_of_ten = %w[10 Jack Queen King]

    if values_of_ten.include?(player_cards.first.rank) && player_cards.last.rank == 'Ace' || 
        values_of_ten.include?(player_cards.last.rank) && player_cards.first.rank == 'Ace'
      @current_gamer = 'Dealer' #dealers turn
    end
  end
  
  def hit
    if playing
      if @current_gamer == 'Player'
        add_new_card @player_hand
      elsif @current_gamer == 'Dealer'
        add_new_card @dealer_hand
      end
    end
  end

  def stand
    if playing
      if @current_gamer == 'Player'
        @current_gamer = 'Dealer'
        @dealer_hand.dealt_cards.first.show = true
      end
      if @dealer_hand.get_value < 17 #need a method to see if the dealer hits a soft 17
        hit
        stand
      end
    end
  end

  def show_hands
    "Player's hand: #{player_hand}\nDealer's hand: #{dealer_hand}\n".colorize(:light_cyan) + 
      (@wallet.show_bet).colorize(:yellow)
  end

  def set_result
    if @player_hand.get_value > 21
      @result = ("Player Busted! You Lost $#{@wallet.bet}!\n".colorize(:red) + @wallet.show_amount.colorize(:yellow))
    elsif @dealer_hand.get_value > 21
      @wallet.add_to_wallet(@wallet.bet)
      @result = ("Dealer busted. You won! $#{@wallet.bet}\n".colorize(:light_blue) + @wallet.show_amount.colorize(:yellow))
    elsif @current_gamer == 'Dealer'
      if @player_hand.get_value == @dealer_hand.get_value
        @wallet.return_money(@wallet.bet)
        @result = ("It's a PUSH\n".colorize(:ligh_cyan) + @wallet.show_amount.colorize(:yellow))
      elsif @player_hand.get_value > @dealer_hand.get_value && @player_hand.get_value != 21
        @wallet.add_to_wallet(@wallet.bet)
        @result = ("Player wins! You won $#{@wallet.bet}\n".colorize(:light_blue) + @wallet.show_amount.colorize(:yellow))
      elsif @player_hand.get_value == 21 && @dealer_hand.get_value != 21
        @wallet.three_to_two(@wallet.bet)
        amount = (1.5 * @wallet.bet).to_i
        @result = ("You won $#{amount}\n".colorize(:magenta) + @wallet.show_amount.colorize(:magenta))
      else @player_hand.get_value < @dealer_hand.get_value
        @result = ("Dealer wins! You Lost $#{@wallet.bet}\n".colorize(:red) + @wallet.show_amount.colorize(:yellow))
      end
    end
  end

  def reshuffle 
    if @deck.deck.size <= 20
      @deck = Deck.new SUITS, RANKS
      @deck.shuffle
      "Shuffling deck"
    else
      "Same deck"
    end
  end


  def play_again
    puts "Press enter to play again or type n(to exit)".upcase
    option = gets.chomp.downcase
    if option == ''
      @current_gamer = 'Player'
      reshuffle
    elsif option == 'n'
      exit
    else
      play_again
    end
  end

  private #allow you to call another method inside a method of the same class

  def add_new_card hand
    hand.add_card(@deck.deal_card)

    if hand.get_value > 21
      if current_gamer == 'Dealer'
        @playing = false
      else
        @playing = false
      end
    end
  end
end
