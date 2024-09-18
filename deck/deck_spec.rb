require_relative 'deck'

RSpec.describe Deck do

  SUITS = %w[Hearts Spades Clubs Diamonds]
  RANKS = %w[Ace 2 3 4 5 6 7 8 9 10 Jack Queen King]

  before do
    @deck = Deck.new SUITS, RANKS #makes a new deck
  end

  it 'should respond to suits' do
    expect(@deck).to respond_to(:suits)
  end

  it 'should respond to ranks' do
    expect(@deck).to respond_to(:ranks)
  end

  it 'should respond to deck' do
    expect(@deck).to respond_to(:deck)
  end
  
  it 'should respond to shuffle' do
    expect(@deck).to respond_to(:shuffle)
  end

  it 'should respond to deal card' do
    expect(@deck).to respond_to(:deal_card)
  end

  it 'should respond to replace_with' do
    expect(@deck).to respond_to(:replace_with)
  end

  it 'pops off stack when card is dealt' do 
    #shuffle deck, and pop card off the end of the deck = dealt card
    dealt_card = @deck.shuffle.last
	expect(@deck.deal_card).to eq(dealt_card)
  end
  
  it 'the dealt card cannot be nil' do
    expect(@deck.deal_card).to_not eq(nil)
  end

  it 'gets a new deck with replace_with' do # this should replace the deck with a new deck
    deck_of_cards = []
    deck_of_cards.push(Card.new("Hearts", "8"))
    deck_of_cards.push(Card.new("Hearts", "9"))
    new_deck = @deck.dup
    new_deck.replace_with(deck_of_cards)
    expect(@deck.deck).to_not eq(new_deck.deck)
  end
  
  it 'should respond to add_deck' do
    expect(@deck).to respond_to(:add_deck)
  end

  it 'should have another deck' do
    # @deck.cards = 52 => set that number of decks = 1
    one_deck = @deck.deck.count 
    @deck.add_deck(1)
    expect(@deck.deck.count).to_not eq(one_deck)
  end
end
