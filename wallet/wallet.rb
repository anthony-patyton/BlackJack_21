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
    if num % 5 == 0 
      if num < 15
        @bet = MINIMUM_BETS[0]
      else num >= 15
        @bet = num.to_i
      end
    else
      "Can only have bets of $5 or higher"
    end
  end

  def show_bet 
    "Your current bet: $#{@bet}"
  end

  def change_bet
  end
end
