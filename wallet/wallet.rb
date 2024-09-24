require_relative '../hand/hand'
require 'colorize'

class Wallet
  attr_reader :initial_amount
  attr_accessor :amount, :bet, :won_or_lost
  MINIMUM_BETS = [15, 25, 50, 500, 1000, 2500, 500000]

  def initialize initial_amount
    @amount = initial_amount
    @bet = MINIMUM_BETS.first
    won_or_lost = ''
  end

  def show_amount
   "Wallet: $#{@amount}"
    # @amount.reduce(&:+).to_i
  end

  def three_to_one
    @amount = @amount + 3 * won_bet
  end

  def add_to_wallet won_bet
    @amount = @amount + 2 * won_bet
    won_or_lost = "You won #{@bet}!".colorize(:light_blue)
  end

  def subtract_from_wallet lost_bet
    @amount = @amount - lost_bet
  end

  def lost_the_game
    won_or_lost = "You lost #{@bet}".colorize(:red)
  end
  
  def change_bet num
    if num % 5 == 0 && num <= MINIMUM_BETS.last
      @bet = num < 15 ? MINIMUM_BETS.first : num.to_i
      puts "Changed bet #{@bet}"
    else num >= MINIMUM_BETS.last
      @bet = MINIMUM_BETS.last
    end
  end

  def show_bet 
    if @bet < MINIMUM_BETS.last
      "Your current bet: $#{@bet}"
    elsif @bet >= MINIMUM_BETS.last
      "Maximum bet is $#{MINIMUM_BETS.last}!!!"
    else
      "Your bet can only be increased by $5"
    end
  end
end
