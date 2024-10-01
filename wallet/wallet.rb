require_relative '../hand/hand'
require 'colorize'

class Wallet
  attr_reader :initial_amount, :history_bets
  attr_accessor :amount, :bet, :second_bet, :won_or_lost
  MINIMUM_BETS = 20

  def initialize initial_amount
    @amount = initial_amount
    @bet = MINIMUM_BETS
    @second_bet = nil
    @history_bets = []
  end

  def format_zeros num
    formated_zeros = num.to_s.reverse.gsub(/...(?=.)/,'\&,').reverse
  end

  def show_amount
    "Wallet: $#{format_zeros(@amount)}"
    # @amount.reduce(&:+).to_i
  end

  def three_to_two won_bet
    @amount = (@amount + ( 1.5 * won_bet)).to_i
  end

  def return_money num
    @amount = @amount + num
  end

  def add_to_wallet won_bet
    @amount = @amount + (2 * won_bet)
  end

  def subtract_from_wallet bet
    @amount = @amount - bet
  end

  def change_bet num
    if num % 5 == 0 
      @bet = num.to_i
      @history_bets << num
      puts "Changed bet #{format_zeros(@bet)}"
    elsif num % 5 != 0
      puts "Please type a correct bet divisible by 5."
    else
      puts "Your bets too high or your broke!".colorize(:red)
      change_bet(gets.strip)
    end
  end

  def winner_winner_chicken_dinner
    puts "Would you like to increase bet? Type number to change bet"
    puts "Leave empty for the same bet or the minimum bet $#{MINIMUM_BETS}?"
    high_stakes = gets.strip.to_i
    if high_stakes == 0
      if @bet >= 15
        @bet = @history_bets.last
        "Same bet: #{@bet}"
      else
        @bet = MINIMUM_BETS
      end
    elsif high_stakes <= @amount
      change_bet(high_stakes)
    else
      puts "Your bets too high!!! Or you're BROKE!!!".colorize(:red)
      winner_winner_chicken_dinner
    end
  end

  def show_bet 
    "Your current bet: $#{format_zeros(@bet)}"
  end
end
