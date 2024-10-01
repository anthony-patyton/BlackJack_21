require_relative 'blackjack'
require 'pry'
require 'colorize'
require 'colorized_string'

SUITS = %w[Hearts Spades Clubs Diamonds]
RANKS = %w[2, 3, 4, 5, 6, 7, 8, 9, 10, Ace, Jack, Queen, King]
MINIMUM_BETS = 20
INITIAL_AMOUNT = 500

puts "Enter how much $$$ you got! BALLER"
initial_amount = gets.strip.to_i
@game = Blackjack.new SUITS, RANKS, initial_amount

@game.deck.which_deck
@game.deck.shuffle

def set_two_results
  value2 = @game.player_second_hand.get_value
  value = @game.player_hand.get_value
  dealer = @game.dealer_hand.get_value
  if value2 > 21 && value > 21
    @result = ("\nYou Lost 2x your bet. #{@game.wallet.bet}/hand\n".colorize(:red) + @game.wallet.show_amount.colorize(:yellow))
  elsif dealer > 21 && value2 <= 21 && value <= 21
    if value2 < 21 && value < 21
      @game.wallet.add_to_wallet(@game.wallet.bet)
      @game.wallet.add_to_wallet(@game.wallet.bet)
      @result = ("\nDealer busted. You won! 2x $#{@game.wallet.bet}\n".colorize(:light_blue) + @game.wallet.show_amount.colorize(:yellow))
    elsif value2 == 21 && value == 21
      @game.wallet.three_to_two(@game.wallet.bet)
      @game.wallet.three_to_two(@game.wallet.bet)
      amount = (1.5 * @game.wallet.bet).to_i
      @result = ("\nYou won 2x $#{amount}\n" + @game.wallet.show_amount).colorize(:magenta)
    else
      @game.wallet.three_to_two(@game.wallet.bet)
      @game.wallet.add_to_wallet(@game.wallet.bet)
      @result = ("\nYou won 1.5x your $#{@game.wallet.bet} && you won $#{@game.wallet.bet}\n".colorize(:light_blue) + @game.wallet.show_amount.colorize(:yellow))
    end
  elsif @game.current_gamer == 'Dealer'
    if value == dealer && value2 == dealer
      @game.wallet.return_money(@game.wallet.bet)
      @game.wallet.return_money(@game.wallet.bet)
      @result = ("You PUSH both hands\n".colorize(:ligh_cyan) + @game.wallet.show_amount.colorize(:yellow))
    elsif value < dealer && value2 < dealer 
      @result = ("\nYou Lost 2x your bet. #{@game.wallet.bet}/hand\n".colorize(:red) + @game.wallet.show_amount.colorize(:yellow))
    else
      unless value2 > 21 || value > 21
        if value2 > dealer 
          unless value2 == 21 
            unless value == 21
              if value > dealer
                @game.wallet.add_to_wallet(@game.wallet.bet)
                @game.wallet.add_to_wallet(@game.wallet.bet)
                @result = ("\nYou won 2x $#{@game.wallet.bet}\n" + @game.wallet.show_amount.colorize(:yellow))
              elsif value == dealer
                @game.wallet.return_money(@game.wallet.bet)
                @game.wallet.add_to_wallet(@game.wallet.bet)
                @result = ("\nYou won $#{@game.wallet.bet}\n" + @game.wallet.show_amount.colorize(:yellow))
              else #value < dealer
                @game.wallet.add_to_wallet(@game.wallet.bet)
                @result = ("\nYou didn't really win anyting!\n" + @game.wallet.show_amount.colorize(:yellow))
              end
            else
              @game.wallet.add_to_wallet(@game.wallet.bet)
              @game.wallet.three_to_two(@game.wallet.bet)
              @result = ("\nYou won 1.5x $#{@game.wallet.bet} and $#{@game.wallet.bet}!\n" + @game.wallet.show_amount.colorize(:yellow))
            end
          else
            unless value == 21
              if value > dealer
                @game.wallet.add_to_wallet(@game.wallet.bet)
                @game.wallet.add_to_wallet(@game.wallet.bet)
                @result = ("You 2x $#{@game.wallet.bet}\n" + @game.wallet.show_amount.colorize(:yellow))
              elsif value < dealer
                @game.wallet.three_to_two(@game.wallet.bet)
                @result = ("You won 0.5x $#{@game.wallet.bet}\n".colorize(:light_cyan) + @game.wallet.show_amount.colorize(:yellow))
              else
                @game.wallet.return_money(@game.wallet.bet)
                @result = ("You won 0.5x $#{@game.wallet.bet} and PUSH the other hand\n" + @game.wallet.show_amount.colorize(:yellow))
              end
            else
              @game.wallet.three_to_two(@game.wallet.bet)
              @game.wallet.three_to_two(@game.wallet.bet)
              @result = ("You won 3x $#{@game.wallet.bet}\n" + @game.wallet.show_amount.colorize(:yellow))
            end
          end
        elsif value2 < dealer
          unless value == 21
            if value == dealer
              @game.wallet.return_money(@game.wallet.bet)
              @result = ("\nYou Lost $#{@game.wallet.bet}\n" + @game.wallet.show_amount.colorize(:yellow))
            else #value > dealer
              @game.wallet.add_to_wallet(@game.wallet.bet)
              @result = ("\nYou Won $#{@game.wallet.bet}\n" + @game.wallet.show_amount.colorize(:yellow))
            end
          else
            @game.wallet.three_to_two(@game.wallet.bet)
            amount = (1.5 * @game.wallet.bet).to_i
            @result = ("\nYou won $#{amount}! You Lost $#{@game.wallet.bet}\n" + @game.wallet.show_amount.colorize(:yellow))
          end
        else
          #same value
          unless value == 21
            if value > dealer
              @game.wallet.add_to_wallet(@game.wallet.bet)
              @result = ("You didn't really win anything\n".colorize(:light_cyan) + @game.wallet.show_amount.colorize(:yellow))
            else 
              @result = ("\nYou Lost $#{@game.wallet.bet}\n" + @game.wallet.show_amount.colorize(:yellow)) # value2 == dealer
            end
          else
            @game.wallet.three_to_two(@game.wallet.bet)
            amount = (1.5 * @game.wallet.bet).to_i
            @result = ("\nYou won $#{amount}! And Push $#{@game.wallet.bet}\n" + @game.wallet.show_amount.colorize(:yellow))
          end
        end
      else
        unless value == 21
          if value == dealer
            @game.wallet.return_money(@game.wallet.bet)
            @result = ("\nYou Lost $#{@game.wallet.bet}\n" + @game.wallet.show_amount.colorize(:yellow))
          else #value > dealer
            @game.wallet.add_to_wallet(@game.wallet.bet)
            @result = ("\nYou only Won $#{@game.wallet.bet}\n" + @game.wallet.show_amount.colorize(:yellow))
          end
        else
          @game.wallet.three_to_two(@game.wallet.bet)
          amount = (1.5 * @game.wallet.bet).to_i
          @result = ("\nYou won $#{amount}! And You Lost $#{@game.wallet.bet}!\n" + @game.wallet.show_amount.colorize(:yellow))
        end
      end
    end
  end
end

def two_hand_game()
  while @game.current_gamer == 'Player' do
    puts "Would you like to split your cards? y/n".colorize(:light_blue)
    input = gets.strip.downcase.to_str
    if input == 'y'
      puts "Splitting hands!".colorize(:yellow)
      @game.split_cards
      puts @game.show_hands
      while @game.player_second_hand.get_value <= 21
        puts "Do you want to Hit(1) or Stand(2)? Second_hand"
        res = gets.strip
        if res == '1'
          puts
          @game.hit
          puts ColorizedString["Player Second Hand: " + @game.player_second_hand.to_s].colorize(:light_green)
          puts ColorizedString["Player First Hand: " + @game.player_hand.to_s].colorize(:light_green)
          puts ColorizedString["Dealer Hand: " + @game.dealer_hand.to_s].colorize(:light_cyan)
        else res == '2'
          puts
          @game.stand
          puts ColorizedString["Player Second Hand: " + @game.player_second_hand.to_s].colorize(:light_green)
          puts ColorizedString["Player First Hand: " + @game.player_hand.to_s].colorize(:light_green)
          puts ColorizedString["Dealer Hand: " + @game.dealer_hand.to_s].colorize(:light_cyan)
          break
        end
      end
      while @game.player_hand.get_value <= 21
        puts "Do you want to Hit(1) or Stand(2)? First_hand"
        res = gets.strip
        if res == '1'
          puts
          @game.hit
          puts ColorizedString["Player Second Hand: " + @game.player_second_hand.to_s].colorize(:light_green)
          puts ColorizedString["Player First Hand: " + @game.player_hand.to_s].colorize(:light_green)
          puts ColorizedString["Dealer Hand: " + @game.dealer_hand.to_s].colorize(:light_cyan)
        else res == '2'
          puts
          @game.stand
          puts ColorizedString["Player Second Hand: " + @game.player_second_hand.to_s].colorize(:light_green)
          puts ColorizedString["Player First Hand: " + @game.player_hand.to_s].colorize(:light_green)
          puts ColorizedString["Dealer Hand: " + @game.dealer_hand.to_s].colorize(:light_cyan)
          break
        end
      end
    elsif input == 'n'
      puts "Do you want to Hit(1) or Stand(2)?"
      res = gets.strip
      if res == '1'
        puts
        @game.hit
        puts ColorizedString["Player Hand: " + @game.player_hand.to_s].colorize(:light_green)
        puts ColorizedString["Dealer Hand: " + @game.dealer_hand.to_s].colorize(:light_cyan)
      else res == '2'
        puts
        @game.stand
        puts ColorizedString["Player Hand: " + @game.player_hand.to_s].colorize(:light_green)
        puts ColorizedString["Dealer Hand: " + @game.dealer_hand.to_s].colorize(:light_cyan)
        break
      end
    end
  end
end

while @game.current_gamer == 'Player'
  def check_player_hands
    values_of_ten = %w[10 Jack Queen King]
    first_card_ace = @game.player_hand.dealt_cards.first.rank
    second_card_ten = @game.player_hand.dealt_cards.last.rank
    first_card_ten = @game.player_hand.dealt_cards.first.rank
    second_card_ace = @game.player_hand.dealt_cards.last.rank
    if first_card_ace.include?('Ace') && values_of_ten.include?(second_card_ten) || values_of_ten.include?(first_card_ten) && second_card_ace.include?('Ace')
      true
    else
      false
    end
  end
  @game.wallet.winner_winner_chicken_dinner
  @game.deal
  # @game.player_hand.dealt_cards = []
  # @game.player_hand.dealt_cards.push(Card.new('Hearts', 'Ace'))
  # @game.player_hand.dealt_cards.push(Card.new('Clubs', 'Ace'))

  puts @game.show_hands

  while @game.player_hand.get_value <= 21 do
    if check_player_hands # got a blackjack
      @game.stand
      puts ColorizedString["Player Hand: " + @game.player_hand.to_s].colorize(:light_green)
      puts ColorizedString["Dealer Hand: " + @game.dealer_hand.to_s].colorize(:light_cyan)
      break
    elsif @game.player_hand.pairs
      two_hand_game()
      break
    else
      puts "Do you want to Hit(1) or Stand(2)?"
      res = gets.strip
      if res == '1'
        puts
        @game.hit
        puts ColorizedString["Player Hand: " + @game.player_hand.to_s].colorize(:light_green)
        puts ColorizedString["Dealer Hand: " + @game.dealer_hand.to_s].colorize(:light_cyan)
      else res == '2'
        puts
        @game.stand
        puts ColorizedString["Player Hand: " + @game.player_hand.to_s].colorize(:light_green)
        puts ColorizedString["Dealer Hand: " + @game.dealer_hand.to_s].colorize(:light_cyan)
        break
      end
    end
  end

  if @game.player_second_hand != nil
    puts set_two_results
    @game.player_second_hand = nil
  else
    puts @game.set_result
  end
  @game.play_again

end
