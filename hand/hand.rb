require 'colorize'

class Hand
  attr_accessor :dealt_cards 

  VALUES = {
    '2' => 2,
    '3' => 3,
    '4' => 4,
    '5' => 5,
    '6' => 6,
    '7' => 7,
    '8' => 8,
    '9' => 9,
    '10'=> 10,
    'Jack' => 10,
    'Queen'=> 10,
    'King' => 10,
    'Ace'  => 1,
  }

  def initialize 
    @dealt_cards = []
  end
  
  def add_card(card)
    @dealt_cards << card
  end

  def get_value
    card_ranks = @dealt_cards.map { |card| card.rank} # replaces 4 lines of code
    result = card_ranks.reduce(0) { |acc, rank| acc + VALUES[rank]} #replaces the card_ranks method
    if card_ranks.include?('Ace') && dealt_cards.first.show 
      result += 10 if result + 10 <= 21 # add 10 to the result if reuslt + 10 <= 21
    end
    result
  end

  def to_s
    report = ""
    dealt_cards.each {|card| report += card.to_s + ", "  if card.show}

    if dealt_cards.first.show == false
      first_value = VALUES[@dealt_cards.first.rank]
      report + "Total Value: " + (get_value - first_value).to_s
    else
      report + "Total Value: " + get_value.to_s
    end
  end

  def pairs
    values_of_ten = %w[10 Jack Queen King]
    if @dealt_cards.first.rank == @dealt_cards.last.rank || values_of_ten.exclude?(dealt_cards.first.rank) && values_of_ten.exclude?(dealt_cards.last.rank) 
      true
    else
      false
    end
  end

  def split_cards
    puts "Splitting cards!".colorize(:lgiht_cyan)
    report = ""
    report_two = ""
    @first_hand = Hand.new
    @second_hand = Hand.new
    @first_hand.dealt_cards.push(dealt_cards[0])
    @second_hand.dealt_cards.push(dealt_cards[1])
    @dealt_cards = []
    @first_hand.dealt_cards.each { |card| report += card.to_s + ", " if card.show}
    @second_hand.dealt_cards.each { |card| report_two += card.to_s + ", " if card.show}

    if @first_hand.dealt_cards.first.show == true
      first_value = VALUES[@first_hand.dealt_cards.first.rank]
      report = (report + "Total Value: " + @first_hand.get_value.to_s)
      report_two = (report_two + "Total Value: " + @second_hand.get_value.to_s)
    else
      report + "Total Value: " + get_value.to_s
    end
    puts "#{report}\n#{report_two}"
  end
end

# Phantom arrays 
# reduce(&:+)
  # card_ranks = []
  # result = 0
  # @dealt_cards.each do |card|
  #   card_ranks << card.rank
  # end
  # card_ranks.each do |rank|
  #   # rank = rank.to_s #just learned that this line does nothing. It already will look look the VALUES{} for a key with '8'. Newer syntax I think
  #   result += VALUES[rank]
  # end
  # result
