#To play black jack:
#First, get one or more decks of cards. Next, shuffle the cards.
#Dispatch a card to the player and a card to the dealer, and a card to the player and a card to the dealer.
#Player decedes if hit or stay. If the total value of the cards exceeds 21, the player looses.
#The dealer hits if total value is less than 17, else show the cards to compete with the player's.

#Major nouns:
#blackjack
#deck
#card
#player
#dealer

#Behavior
#Blackjack: run
#Deck: shuffle, dispatch
#Card
#Player: hit_or_stay
#Dealer: hit_or_show




class Card
  attr_accessor :suit, :value

  def initialize(s, v)
    @suit = s
    @value = v
  end

  def to_s
    "Suit=#{suit}, Value=#{value}"
  end

end

class Deck
  attr_accessor :deck

  def initialize(deck_num=1)
    @deck = []
    begin
     ['a',2,3,4,5,6,7,8,9,'q','j','k'].each do |v|
       ['h','d','s','c'].each do |s|
         @deck << Card.new(s, v)
       end
    end
  end while (deck_num -= 1) > 0
    @deck.shuffle!
  end

  def pop
    deck.pop
  end

end

module Hand

  def get_card=(c)
    cards <<  c
  end

  def show_hand
    cards.each do |c|
      puts c

    end

  end



 def value
  sum=0
  cards.each do |c|
    if c.value.to_i>1 && c.value.to_i<11
      sum+= c.value.to_i
    elsif c.value =="q" 
      sum+=10
    elsif c.value == "k"
      sum+=10
    elsif c.value ==  "j"
      sum+=10
    elsif c.value == "a"
      sum+=10
    end
  end
  aces=cards.select{|c| c.suit=="a"}
  aces.each do |ace|
    sum-=9 if sum > 21
  end
  return sum  
 end

  def busted?
    self.value > 21 ? TRUE : FALSE
  end

end

class Player
  attr_accessor :name, :cards

  include Hand

  def initialize(n='Player')
    @name = n
    @cards = []
  end

  def hit?
    loop do
      puts "Do you want to hit or stay (h/s)?"
      h = gets.chomp.downcase
      return TRUE if h == 'h'
      return FALSE if h == 's'
    end
  end



end # end class Player

class Dealer
  attr_accessor :name, :cards

  include Hand

  def initialize(n='Dealer')
    @name = n
    @cards = []
  end

end

class Game
  attr_accessor :deck, :player, :dealer

  def initialize
    @deck = Deck.new
    @player = Player.new('You')
    @dealer = Dealer.new
  end


  def run
    winner = nil
    player.get_card = deck.pop
    dealer.get_card = deck.pop
    player.get_card = deck.pop
    dealer.get_card = deck.pop

    player.show_hand
    puts "#{player.name}'s cards has #{player.value} points"
    if player.value == 21
      puts "You got Blackjack"
      winner = player.name
    end

    while player.hit? do
      puts "You choose to hit"
      player.get_card = deck.pop
      player.show_hand
      puts "#{player.name}'s cards has #{player.value} points"
      if player.busted?
        puts "You busted!"
        winner = dealer.name
        break
      end
    end

    puts "#{dealer.name}'s cards has #{dealer.value} points"

    while dealer.value < 17  && (winner == nil)
      dealer.get_card = deck.pop
      puts "#{dealer.name}'s cards has #{dealer.value} points"
      if dealer.busted?
        puts "Dealer busted!"
        winner = player.name
        break
      end
      if dealer.value == 21
        puts "Dealer got blackjack"
        winner = dealer.name
      end
    end


    if (winner == nil) && (dealer.value > player.value)
      winner = dealer.name
    elsif (winner == nil) && (dealer.value < player.value)
      winner = player.name
    end
    
    puts "Winner is #{winner}"

  end
end



Game.new.run



