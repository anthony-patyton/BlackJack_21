require_relative 'card'

RSpec.describe Card do

  before do
    suit = 'Hearts'
    rank = '8'

    @card = Card.new suit, rank
  end

  it 'should respond to suit' do
    expect(@card).to respond_to(:suit)
  end
  
  it 'should respond to rank' do
    expect(@card).to respond_to(:rank)
  end
  
  it 'should respond to show' do
    expect(@card).to respond_to(:show)
  end
  
  it 'should return hearts for suit' do
    expect(@card.suit).to eq('Hearts')
  end

  it 'should return 8 for rank' do
    expect(@card.rank).to eq('8')
  end
    
  it 'shoud return true for show' do
    expect(@card.show).to eq(true)
  end
  
end