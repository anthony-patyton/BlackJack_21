class Card
  
  attr_accessor :suit, :rank, :show #allows access, first 3 pass 
  SUITS = %w[Hearts Spades Clubs Diamonds]
  RANKS = %w[2 3 4 5 6 7 8 9 10 Ace Jack Queen King]

  def initialize suit, rank
    @show = true
    
    if SUITS.include?(suit) && RANKS.include?(rank)
      @suit = suit
      @rank = rank
    else
      @suit = 'unknown'
      @rank = 'unkown'
    end
  end

  def to_s
    if show
      "#{rank} of #{suit}"
    else
      ""
    end
  end

end
