require_relative 'blackjack'

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
    
    it 'should respond to split cards' do
      expect(@blackjack).to respond_to(:split_cards)
    end

    describe '#betting hand' do
      
      it 'respond to change_bet' do
        expect(@blackjack).to respond_to(:change_bet)
      end

      it 'should return the minimum_bet of the game' do
        @blackjack.change_bet(0)
        expect(@blackjack.show_bet).to eq("Your current bet: $15")
        expect(@blackjack.bet).to_not eq(nil || 0)
      end

      it 'allows the player to change the bet' do
        @blackjack.change_bet(50)
        expect(@blackjack.show_bet).to eq("Your current bet: $50")
      end

      it 'has a maxium bet for that game' do
        @blackjack.change_bet(505)
        expect(@blackjack.show_bet).to eq(500) && eq("Maximum bet is $500!!!")
      end
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
        expect(@blackjack.bet).to eq(15)
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
        expect(@player_cards.count).to eq(3)
        expect(@dealer_cards.count).to eq(2)
      end

      it 'should return if the player has busted' do
        card1 = Card.new('Hearts', '3')
        card2 = Card.new('Hearts', 'Queen')
        card3 = Card.new('Hearts', '10')
        card4 = Card.new('Hearts', 'Jack')
        card5 = Card.new('Hearts', 'Jack')
        card6 = Card.new('Hearts', 'Jack')
        
        @blackjack = Blackjack.new SUITS, RANKS, initial_amount
        new_deck = [card1, card2, card3, card4, card5, card6]
        @blackjack.deck.replace_with(new_deck)
        @blackjack.deal
        @blackjack.hit
        expect(@blackjack.result).to eq('Player Busted')
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
        expect(@blackjack.result).to eq('Dealer Busted')
      end
    end
  end
end
