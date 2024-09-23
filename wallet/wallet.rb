require_relative '../hand/hand'

class Wallet
  attr_accessor :amount

  def initialize initial_amount
    @amount = [initial_amount]
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
end
