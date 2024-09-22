require_relative '../hand/hand'
require 'pry'

class Wallet
  attr_accessor :amount, :bet
  MINIMUM_BETS = [15, 25, 50, 500]

  def initialize 
    @amount = [0]
    @bet = 0
  end
  
  def show_amount
    @amount.reduce(&:+).to_i
  end

  def add_to_wallet won_bet
    @amount << won_bet
  end

  def subtract_from_wallet lost_bet
    @amount << lost_bet
  end

  def bet_amount num
    if num % 5 == 0 && num <= MINIMUM_BETS.last
      @bet = num < 15 ? MINIMUM_BETS.first : num.to_i
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
