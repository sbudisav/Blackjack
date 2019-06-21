class Card
  attr_accessor :suit, :name, :value

  def initialize(suit, name, value)
    @suit, @name, @value = suit, name, value
  end
end

class Deck
  attr_accessor :playable_cards
  SUITS = [:hearts, :diamonds, :spades, :clubs]
  NAME_VALUES = {
    :two   => 2,
    :three => 3,
    :four  => 4,
    :five  => 5,
    :six   => 6,
    :seven => 7,
    :eight => 8,
    :nine  => 9,
    :ten   => 10,
    :jack  => 10,
    :queen => 10,
    :king  => 10,
    :ace   => [11, 1]}

  def initialize
    shuffle
  end

  def deal_card
    random = rand(@playable_cards.size)
    @playable_cards.delete_at(random)
  end

  def shuffle
    @playable_cards = []
    SUITS.each do |suite|
      NAME_VALUES.each do |name, value|
        @playable_cards << Card.new(suite, name, value)
      end
    end
  end
end

class Hand
  attr_accessor :cards, :hand_value, :ace_count

  def initialize
    @cards = []
    @hand_value = 0
    @ace_count = 0
  end

  def hit(deck)
    new_card = deck.deal_card
    if new_card.name == :ace
      @ace_count +=1
      @hand_value +=11
    else
      @hand_value += new_card.value
    end
    @cards << new_card
  end

end

class Game
  attr_reader :player_hand, :dealer_hand 

  def initialize 
    @deck = Deck.new
    @player_hand = Hand.new
    @dealer_hand = Hand.new
    2.times do
      @player_hand.hit(@deck)
      @dealer_hand.hit(@deck)
    end
    puts "dealer has been dealt the following hand"
    dealer_hand.cards.each do |n|
      puts "#{n.name} of #{n.suit}"
    end
    puts "for a total value of #{@dealer_hand.hand_value}"
    hand_check(@dealer_hand, "Dealer")
    puts "You have been dealt the following hand"
    player_hand.cards.each do |n|
      puts "#{n.name} of #{n.suit}"
    end
    puts "for a total value of #{@player_hand.hand_value}"
    hand_check(@player_hand, "Player")
  end

  def hand_check(hand, who)
    if hand.hand_value > 21 && hand.ace_count > 0 
      hand.ace_count -= 1
      hand.hand_value -= 10
      puts "Ace's value becomes 1, new hand value is #{hand.hand_value}"
    end
    if hand.hand_value == 21 
      abort ("~~~~#{who} wins via blackjack~~~")
    elsif hand.hand_value > 21
      puts hand.hand_value
      abort ("~~~#{who} busts, loses~~~")
    else
    end
  end


  def final_check_winner
    if @player_hand.hand_value == @dealer_hand.hand_value
      puts "Tie game"
    else @player_hand.hand_value < 21 && @dealer_hand.hand_value < 21
      if @player_hand.hand_value > @dealer_hand.hand_value
        puts "Player wins #{@player_hand.hand_value} to #{@dealer_hand.hand_value}"
      else
        puts "Dealer wins #{@dealer_hand.hand_value} to #{@player_hand.hand_value}"
      end
    end
  end

  def gameplay 
    player_done = false
    dealer_done = false

    while player_done == false
      puts "**************"
      puts "Hit or stay (h/s)"
      input = gets.chomp
      if input == 'h'
        new_card = @player_hand.hit(@deck,)
        puts "player after hitting recieves #{new_card.last.name} of #{new_card.last.suit} and is now at #{@player_hand.hand_value}"
        hand_check(@player_hand, "Player")
      elsif input == 's'
        player_done = true
      else input != 'h' || input != 's' 
        puts "invalid input, h for hit, s for stay"
      end
    end

    if @dealer_hand.hand_value < 17
      while @dealer_hand.hand_value < 17
        new_card = @dealer_hand.hit(@deck)
        puts "Dealer after hitting recieves #{new_card.last.name} of #{new_card.last.suit} and is now at #{@dealer_hand.hand_value}"
        hand_check(@dealer_hand, "Dealer")
      end
      dealer_done = true
      puts "dealer stays at #{@dealer_hand.hand_value}"
    else dealer_done = true
    end

    if player_done = true && dealer_done == true 
      final_check_winner
    end
  end
end

game = Game.new
game.gameplay


# require 'test/unit'

# class CardTest < Test::Unit::TestCase
#   def setup
#     @card = Card.new(:hearts, :ten, 10)
#   end
  
#   def test_card_suit_is_correct
#     assert_equal @card.suit, :hearts
#   end

#   def test_card_name_is_correct
#     assert_equal @card.name, :ten
#   end
#   def test_card_value_is_correct
#     assert_equal @card.value, 10
#   end
# end

# class DeckTest < Test::Unit::TestCase
#   def setup
#     @deck = Deck.new
#   end
  
#   def test_new_deck_has_52_playable_cards
#     assert_equal @deck.playable_cards.size, 52
#   end
  
#   def test_dealt_card_should_not_be_included_in_playable_cards
#     card = @deck.deal_card
#     assert(!@deck.playable_cards.include?(card))
#   end


#   def test_shuffled_deck_has_52_playable_cards
#     @deck.shuffle
#     assert_equal @deck.playable_cards.size, 52
#   end
# end

# class GameTest < Test::Unit::TestCase
#   def setup
#     @game = Game.new
#   end

#   def test_initial_hand_is_only_2_cards
#     assert_equal @game.player_hand.cards.size, 2
#   end
# end