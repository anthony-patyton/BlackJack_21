require_relative 'blackjack'
require_relative '../hand/hand'
require_relative '../wallet/wallet'
require 'pry'
require 'colorize'

RSpec.describe Blackjack do
  describe 'instance methods' do

    SUITS = %w[Hearts Spades Clubs Diamonds]
    RANKS = %w[2 3 4 5 6 7 8 9 10 Ace Jack Queen King]
    initial_amount = 500

    before do 
      @blackjack = Blackjack.new SUITS, RANKS, initial_amount
    end

    it 'should respond to wallet' do
      expect(@blackjack).to respond_to(:wallet)
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

    describe 'Dealing Cards' do

      before do 
        @blackjack = Blackjack.new SUITS, RANKS, initial_amount
        @blackjack.deal
        @player_cards = @blackjack.player_hand.dealt_cards
        @dealer_cards = @blackjack.dealer_hand.dealt_cards
      end

      it 'should return 2 cards for the dealer and player' do
        expect(@player_cards.count).to eq(2)
        expect(@dealer_cards.count).to eq(2)
      end

      it 'should not display the dealers first card' do
        expect(@dealer_cards.first.show).to eq(false)
      end

      it 'should return the return the bet' do
        # expect(@blackjack.bet).to eq(15)
      end

      it 'should end the players turn if a blackjack is dealt' do
        card1 = Card.new('Hearts', '3')
        card2 = Card.new('Hearts', 'Ace')
        card3 = Card.new('Hearts', '4')
        card4 = Card.new('Hearts', 'Jack')

        @blackjack = Blackjack.new SUITS, RANKS, initial_amount #making it replace the previous deck
        new_deck = [card4, card3, card2, card1]
        @blackjack.deck.replace_with(new_deck)
        @blackjack.deal

        expect(@blackjack.current_gamer).to eq('Dealer')
      end
    end

    describe 'Hitting Hand' do

      before do
        initial_amount = 500
        @blackjack = Blackjack.new SUITS, RANKS, initial_amount
        @blackjack.deal
        @player_cards = @blackjack.player_hand.dealt_cards
        @dealer_cards = @blackjack.dealer_hand.dealt_cards
      end

      it 'should only hit if playing is true' do
        expect(@blackjack.playing).to eq true
      end

      it 'should return 3 cards for the player and 2 for the dealer' do
        @blackjack.hit
        # expect(@player_cards.count).to eq(3)
        # expect(@dealer_cards.count).to eq(2)
      end

      it 'should return if the player has busted' do
        card1 = Card.new('Hearts', '3')
        card2 = Card.new('Hearts', 'Queen')
        card3 = Card.new('Hearts', '10')
        card4 = Card.new('Hearts', 'Jack')
        card5 = Card.new('Hearts', 'Jack')
        card6 = Card.new('Hearts', 'Jack')

        @blackjack = Blackjack.new SUITS, RANKS, initial_amount
        @bet = 15
        new_deck = [card1, card2, card3, card4, card5, card6]
        @blackjack.deck.replace_with(new_deck)
        @blackjack.deal
        @blackjack.hit
        # expect(@blackjack.result).to eq("Player Busted. You lost #{@bet}")
        # expect(@blackjack.wallet.amount).to eq(485)
      end

      it 'should return if the dealer has busted' do
        card1 = Card.new('Hearts', '10')
        card2 = Card.new('Hearts', '10')
        card3 = Card.new('Hearts', 'Jack')
        card4 = Card.new('Hearts', 'Jack')
        card5 = Card.new('Hearts', '5')

        @blackjack = Blackjack.new SUITS, RANKS, initial_amount
        new_deck = [card1, card2, card3, card4, card5]
        @blackjack.deck.replace_with(new_deck)
        @blackjack.deal
        @blackjack.current_gamer = 'Dealer'
        @blackjack.hit
        # expect(@blackjack.result).to eq('Dealer Busted')
        # expect(@blackjack.wallet.show_amount).to eq("Wallet: $515")
      end
    end

    describe '#Stand' do
      before do
        initial_amount = 500
        @blackjack = Blackjack.new SUITS, RANKS, initial_amount
      end

      it 'should switch current gamer from player to dealer' do
        card1 = Card.new('Hearts', 'Ace')
        card2 = Card.new('Hearts', '10')
        card3 = Card.new('Hearts', '5')
        card4 = Card.new('Clubs', '4')
        card5 = Card.new('Hearts', 'Ace')
        card6 = Card.new('Hearts', '6')

        new_deck = [card1, card2, card3, card4, card5, card6]
        @blackjack.deck.replace_with(new_deck)
        @blackjack.deal
        @blackjack.stand
        expect(@blackjack.current_gamer).to eq('Dealer')
        expect(@blackjack.set_result)
      end
      
      it 'dealer should hit when the total value of cards is lest than 17' do
        card1 = Card.new('Hearts', '10')
        card2 = Card.new('Hearts', '10')
        card3 = Card.new('Hearts', '6')
        card4 = Card.new('Hearts', '6')
        card5 = Card.new('Hearts', 'Jack')

        new_deck = [card1, card2, card3, card4, card5]
        @blackjack.deck.replace_with(new_deck)
        @blackjack.deal
        expect(@blackjack.dealer_hand.get_value).to eq(16)
        @blackjack.stand
        expect(@blackjack.dealer_hand.get_value).to eq(26)
        expect(@blackjack.dealer_hand.dealt_cards.first.show).to eq(true)
      end
    end

    describe 'Show hands' do

      before do
        initial_amount = 500
        @blackjack = Blackjack.new SUITS, RANKS, initial_amount
        @blackjack.deal
      end

      it 'should return the gamers hands' do
        # expect(@blackjack.show_hands).to match(/Player hand:/)
        # expect(@blackjack.show_hands).to match(/Dealer hand:/)
        # expect(@blackjack.show_hands).to match(/Your current bet: $#{@bet}/)
      end
    end

    describe 'Setting Results' do

      before do
        initial_amount = 500
        @blackjack = Blackjack.new SUITS, RANKS, initial_amount
      end

      it 'returns if the player busts' do
        card1 = Card.new('Hearts', '3')
        card2 = Card.new('Hearts', 'Queen')
        card3 = Card.new('Hearts', 'King')
        card4 = Card.new('Hearts', '10')
        card5 = Card.new('Hearts', '10')
        card6 = Card.new('Hearts', '8')
        new_deck = [card1, card2, card3, card4, card5, card6]
        @blackjack.deck.replace_with(new_deck)
        @blackjack.deal
        @blackjack.hit #Player should hit and bust
        # expect(@blackjack.set_result).to eq('Player Busts!')
      end
      
      it 'returns its a tie' do
        card2 = Card.new('Hearts', 'Ace')
        card3 = Card.new('Hearts', 'Jack')
        card4 = Card.new('Diamonds', '10')
        card5 = Card.new('Hearts', '10')
        card6 = Card.new('Clubs', '10')
        # new_deck = [card1, card2, card3, card4, card5, card6]
        # @blackjack.deck.replace_with(new_deck)
        # @blackjack.deal
        # @blackjack.hit
        # @blackjack.stand
        # @blackjack.hit
        # expect(@blackjack.set_result).to eq("It's a Tie!")
      end

      it 'returns if the player wins' do
        card1 = Card.new('Hearts', 'Ace')
        card2 = Card.new('Hearts', 'Ace')
        card3 = Card.new('Hearts', 'Ace')
        card4 = Card.new('Diamonds', '7')
        card5 = Card.new('Hearts', '10')
        card6 = Card.new('Clubs', '10')
        new_deck = [card1, card2, card3, card4, card5, card6]
        @blackjack.deck.replace_with(new_deck)
        @blackjack.deal
        @blackjack.stand
        # expect(@blackjack.set_result).to eq("Player wins!")
      end
    end

    describe 'spitting cards' do
      before do
        initial_amount = 500
        @blackjack = Blackjack.new SUITS, RANKS, initial_amount
      end

      it 'should split_cards and hit ' do
        card1 = Card.new('Spades', '10')
        card2 = Card.new('Hearts', '3')
        card3 = Card.new('Hearts', '10')
        card4 = Card.new('Diamonds', '10')
        card5 = Card.new('Clubs', 'Ace')
        card6 = Card.new('Diamonds', '3')
        card7 = Card.new('Hearts', 'Ace')
        card8 = Card.new('Clubs', 'Queen')
        new_deck = [card1, card2, card3, card4, card5, card6, card7, card8]
        @blackjack.deck.replace_with(new_deck)
        @blackjack.deal
        expect(@blackjack.player_hand.pairs).to eq(true)
        @blackjack.split_cards
        expect(@blackjack.player_hand.to_s).to eq('Ace of Hearts, Total Value: 11')
        expect(@blackjack.player_second_hand.to_s).to eq('Ace of Clubs, Total Value: 11')
        expect(@blackjack.current_hand).to eq(false)
        @blackjack.hit
        expect(@blackjack.player_second_hand.dealt_cards.count).to eq(2)
        @blackjack.stand
        expect(@blackjack.current_hand).to eq(true)
        @blackjack.hit
        expect(@blackjack.player_hand.to_s).to eq('Ace of Hearts, 10 of Hearts, Total Value: 21')
        @blackjack.stand
        expect(@blackjack.current_gamer).to eq('Dealer')
        end

      it 'should bust the second hand and win the on the other hand' do
        card10 = Card.new('Spades', '10')
        card9 = Card.new('Spades', 'Jack')
        card8 = Card.new('Spades', 'Queen')
        card7 = Card.new('Hearts', 'Jack')
        card6 = Card.new('Hearts', '10')
        card5 = Card.new('Diamonds', '5')
        card4 = Card.new('Clubs', 'Ace')
        card3 = Card.new('Diamonds', '10')
        card2 = Card.new('Hearts', 'Ace')
        card1 = Card.new('Clubs', 'Queen')
        new_deck = [card10, card9, card8, card7, card6, card5, card4, card3, card2, card1]
        @blackjack.deck.replace_with(new_deck)
        @blackjack.deal
        @blackjack.split_cards
        expect(@blackjack.current_hand).to eq(false)
        @blackjack.hit
        @blackjack.hit
        @blackjack.hit
        expect(@blackjack.player_second_hand.get_value).to eq(26)
        expect(@blackjack.current_hand).to eq(true)
        @blackjack.hit
        expect(@blackjack.player_hand.get_value).to eq(21)
        expect(@blackjack.dealer_hand.get_value).to eq(20)
      end
      
      it 'should show the second hand won and the first hand lost' do
      end

      it 'should show the second hand lost and the first hand won' do
      end

      it 'should show the dealer won if both busted or < dealer hand value' do
      end
      
      it 'should show push' do
      end

      it 'should return the bets' do
        card10 = Card.new('Spades', '10')
        card9 = Card.new('Spades', 'Jack')
        card8 = Card.new('Spades', 'Queen')
        card7 = Card.new('Hearts', 'Jack')
        card6 = Card.new('Hearts', '9')
        card5 = Card.new('Spades', '9')
        card4 = Card.new('Clubs', 'Ace')
        card3 = Card.new('Diamonds', '9')
        card2 = Card.new('Hearts', 'Ace')
        card1 = Card.new('Clubs', 'Queen')
        new_deck = [card10, card9, card8, card7, card6, card5, card4, card3, card2, card1]
        @blackjack.deck.replace_with(new_deck)
        @blackjack.deal
        @blackjack.split_cards
        @blackjack.hit
        @blackjack.stand
        expect(@blackjack.player_second_hand.get_value).to eq(20) 
        expect(@blackjack.current_hand).to eq(true)
        @blackjack.hit
        expect(@blackjack.player_hand.get_value).to eq(20)
        expect(@blackjack.dealer_hand.get_value).to eq(19)
        expect(@blackjack.wallet.bet).to eq(20)
        expect(@blackjack.wallet.second_bet).to eq(20)
        expect(@blackjack.wallet.amount).to eq(460)
        @blackjack.set_result
        expect(@blackjack.wallet.amount).to eq(540)
      end
    end
  end
end
