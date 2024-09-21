require_relative '../card/card'
require_relative '../hand/hand'
require_relative 'wallet'
require 'pry'

RSpec.describe Wallet do

  before do
    @hand = Hand.new
    @wallet = Wallet.new
  end

  it 'responds to initial amount' do
    expect(@wallet).to respond_to(:amount)
  end
  
  it 'responds to bet' do
    expect(@wallet).to respond_to(:bet)
  end

  describe '#Computational amounts with wallet' do

    it 'show how much money the player has' do
      expect(@wallet.show_amount).to eq(0)
    end
    
    it 'adds to the initial amount' do
      expect(@wallet).to respond_to(:add_to_wallet)

      won_bet = 25
      @wallet.add_to_wallet(won_bet)
      expect(@wallet.show_amount).to eq(25)
    end

    it 'subtract from the initial amount' do
      expect(@wallet).to respond_to(:subtract_from_wallet)
      
      @wallet.add_to_wallet(500)
      @wallet.subtract_from_wallet(-75)
      expect(@wallet.show_amount).to eq(425)
    end
  end

  describe '#betting hand' do

    it 'respond to bet_amount' do
      expect(@wallet).to respond_to(:bet_amount)
    end

    it 'should return the minimum_bet of the game' do
      @wallet.bet_amount(0)
      expect(@wallet.show_bet).to eq("Your current bet: $15")
      expect(@wallet.bet).to_not eq(nil || 0)
    end

    it 'allows the player to change the bet' do
      @wallet.change_bet(50)
      expect(@wallet.show_bet).to eq(50)
    end

    it 'have a maxium bet for that game' do
      @wallet.change_bet(505)
      expect(@wallet.show_bet).to eq(500) && eq("Maximum bet is $500!!!")
    end
    
    it 'shows options to increase bet or leave it the same or at minimum bet' do

      @wallet.bet_options(1) #leave it the same
      @wallet.bet_options(2) #increase bet by specific amount
      @wallet.bet_options(3) #minimum, bet_amount = $15

    end
  end
end
