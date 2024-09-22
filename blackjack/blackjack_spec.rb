require_relative '../hand/hand'
require_relative '../deck/deck'
require_relative '../wallet/wallet.rb'
require_relative 'blackjack'

RSpec.describe Blackjack do
  describe 'instance methods' do

    SUITS = %w[Hearts Spades Clubs Diamonds]
    RANKS = %w[2 3 4 5 6 7 8 9 10 Ace Jack Queen King]

    before do 
      @blackjack = Blackjack.new SUITS, RANKS
    end
    
    it 'should respond to player hand' do
      expect(@blackjack).to respond_to(:player_hand)
    end

    it 'should respond to dealer hand' do
      expect(@blackjack).to respond_to(:dealer_hand)
    end

    it 'should respond to playing' do
      expect(@blackjack).to respond_to(:playing)
    end

    it 'should respond to current_gamer hand' do
      expect(@blackjack).to respond_to(:current_gamer)
    end

    it 'should respond to bet' do
      expect(@blackjack).to respond_to(:bet_amount)
    end

    it 'should respond to deal hand' do
      expect(@blackjack).to respond_to(:deal)
    end

    it 'should respond to hit hand' do
      expect(@blackjack).to respond_to(:hit)
    end

    it 'should respond to stand' do
      expect(@blackjack).to respond_to(:stand)
    end

    it 'should respond to show hands' do
      expect(@blackjack).to respond_to(:show_hands)
    end

    it 'should respond to set_result' do
      expect(@blackjack).to respond_to(:set_result)
    end
  end
end
