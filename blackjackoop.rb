class Card
  attr_accessor :suit, :value

  def initialize(s,v)
    @suit = s
    @value = v
  end

  def to_s
    "The #{value} of #{suit}"
  end
end

class Deck(num_decks)
  attr_accessor :cards

  def initialize(num_decks)
    @cards = []
    ['Hearts', 'Spades', 'Diamonds', 'Clubs']. each do |suit|
      ['2', '3', '4', '5', '6', '7', '8', '9', '10', 'Jack', 'Queen', 'King', 'Aces']. each do |value|
        @cards << Card.new(suit, value)
      end
    end
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

class Hand
end

#class Dealer

 # def initialize
  #  @stake = 500
  #end

 # def dealer_hand

  #end

  #def hit_or_stay
   # if hand_total(dealer_hand) < 17 || hand_total(dealer_hand) < hand_total(player_hand)
      # do deal card
    #end
#end
  

#

#class Blackjack # this is the game engine!
# welcome message, set up Deck and get Player name
# deal first two cards to Dealer and Player
# compute and check total for blackjack
# if not, display all hands and totals and ask player to hit or stay
# if hit, c&c total for blackjack or bust
  # if blackjack, do blackjack dance! (put all in end_result module?)
  # if bust, do oops 
# if stay, dealer turn to hit or stay
# do end_game module
# ask if player wants to play again?
# Will total be a method within end_game or it is independent?
# HOW DO I pass on total back? return, global variable, super-variable? use accessor????


#