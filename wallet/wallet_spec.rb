require_relative 'wallet'

RSpec.describe Wallet do

  before do
    initial_amount = 500
    @wallet = Wallet.new initial_amount
  end

  it 'responds to initial amount' do
    expect(@wallet).to respond_to(:amount)
  end
  
  it 'responds to bet' do
    expect(@wallet).to respond_to(:bet)
  end

  describe '#Computational amounts with wallet' do

    it 'show how much money the player has' do
      expect(@wallet.show_amount).to eq("Wallet: $500")
    end
    
    it 'adds to the initial amount' do
      expect(@wallet).to respond_to(:add_to_wallet)

      won_bet = 25
      @wallet.add_to_wallet(won_bet)
      expect(@wallet.show_amount).to eq("Wallet: $550")
    end

    it 'subtract from the initial amount' do
      @wallet.subtract_from_wallet(500)
      expect(@wallet.show_amount).to eq("Wallet: $0")
    end
  end
  describe '#betting hand' do
    
    it 'respond to change_bet' do
      expect(@wallet).to respond_to(:change_bet)
    end

    it 'should return the minimum_bet of the game' do
      @wallet.change_bet(0)
      expect(@wallet.show_bet).to eq("Your current bet: $15")
      expect(@wallet.bet).to_not eq(nil || 0)
    end

    it 'allows the player to change the bet' do
      @wallet.change_bet(50)
      expect(@wallet.show_bet).to eq("Your current bet: $50")
    end
  end
end
