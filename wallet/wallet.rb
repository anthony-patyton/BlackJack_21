require_relative '../hand/hand'
require 'colorize'

class Wallet
  attr_reader :initial_amount, :history_bets
  attr_accessor :amount, :bet, :won_or_lost
  MINIMUM_BETS = [15, 25, 50, 500, 1000, 2500, 500000]

  def initialize initial_amount
    @amount = initial_amount
    @bet = MINIMUM_BETS.first
    won_or_lost = ''
    @history_bets = Array.new
  end

  def show_amount
    "Wallet: $#{@amount}"
    # @amount.reduce(&:+).to_i
  end

  def three_to_one
    @amount = @amount + 3 * won_bet
  end

  def return_money num
    @amount = @amount + num
  end

  def add_to_wallet won_bet
    @amount = @amount + 2 * won_bet
    won_or_lost = "You won #{@bet}!".colorize(:light_blue)
  end

  def subtract_from_wallet lost_bet
    @amount = @amount - lost_bet
  end

  def change_bet num
    if num % 5 == 0 && num <= @amount
      @bet = num < 15 ? MINIMUM_BETS.first : num.to_i
      puts "Changed bet #{@bet}"
    else num >= MINIMUM_BETS.last
      @bet = MINIMUM_BETS.last
    end
    
    @history_bets << num
  end

  def show_bet 
    "Your current bet: $#{@bet}"
  end
end
