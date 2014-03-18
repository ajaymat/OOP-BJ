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
    puts "                 => Total: #{hand_total}"
  end

  def hand_total
    value = cards.map{ |card| card.value }

    hand_total = 0
    value.each do |val|
      if val == 'Ace'
        hand_total +=11
      else
        hand_total += (val.to_i == 0 ? 10: val.to_i)
      end
    end

    value.select { |val| val == "Aces"}.count.times do
      break if hand_total <= 21
      hand_total -= 10
    end

    hand_total
  end

  def add_card(new_card)
    cards << new_card
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

end

deck = Deck.new(2)
player = Player.new('Ajay')
dealer = Dealer.new
player.add_card(deck.deal_card)
dealer.add_card(deck.deal_card)
player.add_card(deck.deal_card)
dealer.add_card(deck.deal_card)
player.add_card(deck.deal_card)

puts player.show_hand
puts dealer.show_hand
