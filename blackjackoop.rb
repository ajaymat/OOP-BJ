class Card
  attr_accessor :suit, :value

  def initialize(s,v)
    @suit = s
    @value = v
  end

  def to_s
    "#{value} of #{suit}"
  end
end

class Deck
  attr_accessor :cards

  def initialize(num_decks)
    @cards = []
    ['Hearts', 'Spades', 'Diamonds', 'Clubs']. each do |suit|
      ['2', '3', '4', '5', '6', '7', '8', '9', '10', 'Jack', 'Queen', 'King', 'Ace']. each do |value|
        @cards << Card.new(suit, value)
      end
    end
    @cards = @cards * num_decks
    shuffle_cards
  end

  def shuffle_cards
    cards.shuffle!
  end

  def deal_card
    cards.pop
  end

  def size
    cards.size
  end
end

module Hand

  def show_hand
    puts "#{name}'s Hand ----"
    cards.each do |card|
      puts "                  => #{(card)}"
    end
    puts "                  => Total: #{hand_total}"
  end

  def hand_total
    hand_total = 0
    card_value = cards.map{ |card| card.value }

    card_value.each do |val|
      if val == 'Ace'
        hand_total +=11
      else
        hand_total += (val.to_i == 0 ? 10: val.to_i)
      end
    end

    card_value.select { |val| val == "Ace"}.count.times do
      break if hand_total <= Blackjack::BLACKJACK_VALUE
      hand_total -= 10
    end

    hand_total
  end

  def add_card(new_card)
    cards << new_card
  end

  def is_busted?
    hand_total > Blackjack::BLACKJACK_VALUE
  end 

end

class Player
  include Hand

  attr_accessor :name, :cards

  def initialize(n)
    @name = n
    @cards = []
  end
end

class Dealer
  include Hand

  attr_accessor :name, :cards

  def initialize
    @name = "Dealer"
    @cards = []
  end

  def show_flop
    puts "Dealer's Hand ----"
    puts "                  First card is hidden"
    puts "                  Second card => #{(cards[1])}"
  end

end

class Blackjack
  include Hand
  attr_accessor :deck, :player, :dealer

  BLACKJACK_VALUE = 21
  DEALER_HIT_MIN = 17

  def initialize
    @deck = Deck.new(2)
    @player = Player.new("Player1")
    @dealer = Dealer.new
  end

  def set_player_name
    puts "What's your name?"
    player.name = gets.chomp
  end

  def start
    set_player_name
    start_game
  end

  def start_game
    deal_cards
    show_flop
    player_turn
    dealer_turn
    end_game
  end

  def deal_cards
    player.add_card(deck.deal_card)
    dealer.add_card(deck.deal_card)
    player.add_card(deck.deal_card)
    dealer.add_card(deck.deal_card)
  end

  def show_flop
    player.show_hand
    dealer.show_flop
  end

  def blackjack_or_bust(player_or_dealer)
    if player_or_dealer.hand_total == BLACKJACK_VALUE
      if player_or_dealer.is_a?(Dealer)
        puts "Sorry, dealer hit blackjack. #{player.name} loses"
      else
        puts "Congratulations, #{player.name} hit blackjack! You win!"
      end  
      play_again?
    elsif player_or_dealer.is_busted?
      if player_or_dealer.is_a?(Dealer)
        puts "Congratulations, dealer busted. #{player.name} win!"
      else
        puts "Sorry, #{player.name} busted. You lose"
      end
      play_again?
    end
  end

  def player_turn
    blackjack_or_bust(player)
    blackjack_or_bust(dealer)

    while 10 > 9
      puts "#{player.name}, what would you like to do? 1) hit 2) stay"
      ans = gets.chomp

      if !['1', '2'].include?(ans)
        puts "Error: you must enter 1 or 2"
        next
      end

     if ans == "2"
        puts "You chose to stay at #{player.hand_total}."
        break
      else    
        new_card = deck.deal_card
        puts "Dealt #{new_card} to #{player.name}"
        player.add_card(new_card)
        puts "Your total is now #{player.hand_total}"
        blackjack_or_bust(player)
      end
    
    end
  end

  def dealer_turn
    puts ''
    puts "Dealer's turn"
    dealer.show_hand
    while dealer.hand_total < DEALER_HIT_MIN
      new_card = deck.deal_card
      dealer.add_card(new_card)
      puts "Dealt #{new_card} to Dealer"
      puts "Dealer's total is now #{dealer.hand_total}"
      blackjack_or_bust(dealer)
    end  
    puts "Dealer stays at #{dealer.hand_total}."
  end

  def end_game
    if player.hand_total > dealer.hand_total
      puts "Congratuations #{player.name}, you win!"
      play_again?
    elsif player.hand_total < dealer.hand_total
      puts "Sorry #{player.name}, you lose"
      play_again?
    else
      puts "It's a tie!"
      play_again?
    end
  end

  def play_again?
    puts ""
    puts "#{player.name}, would you like to continue playing 1) Yes 2) No"
    ans = gets.chomp

    while !['1', '2'].include?(ans)
      puts "Error: pls enter '1' or '2' "
      puts ""
      puts "#{player.name}, would you like to continue playing 1) Yes 2) No"
      ans = gets.chomp
    end

    if ans == '1'
      player.cards = []
      dealer.cards = []
      start_game
    else
      exit
    end
  
  end

end

game = Blackjack.new
game.start
