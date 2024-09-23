require_relative '../deck/deck'
require_relative '../hand/hand'
require_relative '../wallet/wallet'

class Blackjack

  attr_reader :player_hand, :dealer_hand, :deck, :playing
  attr_accessor :current_gamer, :change_bet, :bet, :wallet, :result
  MINIMUM_BETS = [15, 25, 50, 500]


  def initialize suits, ranks, initial_amount
    @player_hand = nil
    @dealer_hand = nil
    @deck = Deck.new suits, ranks
    @wallet = Wallet.new initial_amount 
    @deck.shuffle
    @playing = false
    @current_gamer = 'Player'
    @bet = MINIMUM_BETS.first
    @result = ''
  end

  def change_bet num
    if num % 5 == 0 && num <= MINIMUM_BETS.last
      @bet = num < 15 ? MINIMUM_BETS.first : num.to_i
    else num >= MINIMUM_BETS.last
      @bet = MINIMUM_BETS.last
    end
  end

  def show_bet 
    if @bet < MINIMUM_BETS.last
      "Your current bet: $#{@bet}"
    elsif @bet >= MINIMUM_BETS.last
      "Maximum bet is $#{MINIMUM_BETS.last}!!!"
    else
      "Your bet can only be increased by $5"
    end
  end

  def deal
    @wallet.amount = 500
    @wallet.subtract_from_wallet(@bet)
    @dealer_hand = Hand.new
    @player_hand = Hand.new

    2.times do
      @dealer_hand.add_card(@deck.deal_card)
      @player_hand.add_card(@deck.deal_card)
    end
    @dealer_hand.dealt_cards.first.show = false
    @playing = true
    player_cards = @player_hand.dealt_cards
    values_of_ten = %w[10 Jack Queen King]

    if values_of_ten.include?(player_cards.first.rank) && player_cards.last.rank == 'Ace' || 
        values_of_ten.include?(player_cards.last.rank) && player_cards.first.rank == 'Ace'
      @current_gamer = 'Dealer' #dealers turn
    end
  end
  
  def hit
    if playing
      if @current_gamer == 'Player'
        add_new_card @player_hand
      elsif @current_gamer = 'Dealer'
        add_new_card @dealer_hand
      end
    end
  end

  def stand
  end

  def show_hands
  end

  def set_result
  end

  def split_cards
  end

  def to_s
    puts "Player has #{@player_hand.get_value}"
    puts "Dealer has #{@dealer_hand.get_value}"
  end

  private #allow you to call another method inside a method of the same class

  def add_new_card hand
    hand.add_card(@deck.deal_card)

    if hand.get_value > 21
      @result = "#{@current_gamer} Busted"
      @playing = false
    end
  end
end
