# Modified after reading the TeaLeaf Solution

 def calculate(card)
 	sum=0
 	card.each do |c|
 		if c[1].to_i>1 && c[1].to_i<11
 			sum+= c[1]
 		elsif c[1] =="queen" 
 			sum+=10
 		elsif c[1] == "king"
 			sum+=10
 		elsif c[1] ==  "jack"
 			sum+=10
 		elsif c[1] == "ace"
 			sum+=10
 		end
 	end
 	aces=card.select{|c| c[1]=="ace"}
 	aces.each do |ace|
 		sum-=9 if sum > 21
 	end
 	return sum	
 end


#Set new cards
card_suite=["spade", "heart", "diamond", "club"]
card_rank=["ace", 2, 3, 4, 5, 6, 7, 8, 9, 10, "queen", "king", "jack"]


#Welcome
puts "Welcome to Black Jack!"
puts "You name?"
name=gets.chomp
puts "Welcome #{name} !"

#Begin Game!
#Shuffle Cards
	card_shuffle=[]
	player_card=[]
	host_card=[]
	card_new=[]

	card_new[0]=card_suite.product(card_rank)
	card_new[1]=card_suite.product(card_rank)

	puts "Deck number: #{card_new.count}"
	
	card_new.each do |deck|
		p deck.count
		card_shuffle+=deck
		p card_shuffle.count
	end
	card_shuffle.shuffle!
	puts ""
	puts "#{card_new.count}, #{card_shuffle.count}, #{card_shuffle}"

#Dispatch Cards

	player_card << card_shuffle.pop
	host_card << card_shuffle.pop	
	player_card << card_shuffle.pop
	host_card << card_shuffle.pop

	player_sum=  calculate(player_card)
	puts "Your card: #{player_card} with #{player_sum} points"
	host_sum=calculate(host_card)
	puts "Host's card: #{host_card} with #{host_sum} points"

#Player Starts
	begin
		
		if player_sum>21
			puts "You busted!"
			break
		elsif player_sum==21
			puts "You got Blackjack. You WIN!"
			break
		else
			puts "Hit or Stay? (h/s)"
			action=gets.chomp.downcase
			if action=="h"
				player_card << card_shuffle.pop 
				player_sum=  calculate(player_card)
				puts "Your card: #{player_card} with #{player_sum} points"
			end
		end
	end while action == "h"
	
#Host starts!
	loop do
		if host_sum>21
			puts "Host busted!"
			exit
		elsif host_sum==21
			puts "Host got Blackjack. You LOOSE!"
			exit
		end

		host_sum=calculate(host_card)

		if host_sum < 17
			host_card << card_shuffle.pop
		else	#host_sum >17, show hand
			if host_sum > player_sum
				puts "Host win! You LOOSE!"
				exit
			elsif host_sum == player_sum
				puts "It's a tie"
				exit
			else 
				puts "You WIN!, #{name} is the BEST!"
				exit
			end

		end
		host_sum=calculate(host_card)
		puts "Host's card: #{host_card} with #{host_sum} points"
	end












