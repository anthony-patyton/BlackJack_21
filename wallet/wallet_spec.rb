require_relative 'wallet'

RSpec.describe Wallet do

  before do
    initial_amount = 500
    @wallet = Wallet.new initial_amount
  end

  it 'responds to initial amount' do
    expect(@wallet).to respond_to(:amount)
  end
  
  # it 'responds to bet' do
  #   expect(@wallet).to respond_to(@bet)
  # end

  describe '#Computational amounts with wallet' do

    it 'show how much money the player has' do
      expect(@wallet.show_amount).to eq(500)
    end
    
    it 'adds to the initial amount' do
      expect(@wallet).to respond_to(:add_to_wallet)

      won_bet = 25
      @wallet.add_to_wallet(won_bet)
      expect(@wallet.show_amount).to eq(525)
    end

    it 'subtract from the initial amount' do
      expect(@wallet).to respond_to(:subtract_from_wallet)
      
      @wallet.add_to_wallet(500)
      @wallet.subtract_from_wallet(-75)
      expect(@wallet.show_amount).to eq(925)
    end
  end
end
