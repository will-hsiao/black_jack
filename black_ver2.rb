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
 	aces.count.times {sum-=9 if sum > 21}

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


begin
#Begin Game!
	puts "\n-----------------Welcome to Black Jack!------------------"
#Shuffle Cards
	card_shuffle=[]
	player_card=[]
	host_card=[]
	card_new=[]
	f_gameover = FALSE

	card_new[0]=card_suite.product(card_rank)
	card_new[1]=card_suite.product(card_rank)

	puts "Deck number: #{card_new.count}"
	
	card_new.each do |deck|
		card_shuffle+=deck
	end
	card_shuffle.shuffle!
	puts "Card count = #{card_shuffle.count}"



#Dispatch Cards

	player_card << card_shuffle.pop
	host_card << card_shuffle.pop	
	player_card << card_shuffle.pop
	host_card << card_shuffle.pop

	player_sum=  calculate(player_card)
	puts "#{name}'s card: #{player_card} with #{player_sum} points"
	host_sum=calculate(host_card)
	puts "Host's card: #{host_card} with #{host_sum} points"

#Player Starts
	begin
		
		if player_sum < 21
			puts "Hit or Stay? (h/s)"
			action=gets.chomp.downcase
			if action=="h"
				puts "You choose to hit"
				player_card << card_shuffle.pop 
				player_sum=  calculate(player_card)
				puts "Your card: #{player_card} with #{player_sum} points"
			else
				puts "You choose to stay"
			end
		else #player_sum >= 21
				puts "You busted!" if player_sum>21
				puts "You got Blackjack. You WIN!" if player_sum==21
				f_gameover=TRUE
		end
	end while action == "h" && !f_gameover
	
#Host starts!
	while f_gameover == FALSE
		if host_sum < 17
			host_card << card_shuffle.pop
			host_sum=calculate(host_card)
			puts "Host's card: #{host_card} with #{host_sum} points"
		else 
			puts "Host busted!" if host_sum > 21
			puts "Host got Blackjack. You LOSE!" if host_sum == 21
			puts "Host win! You LOSE!" if host_sum > player_sum  && host_sum < 21
			puts "It's a tie" if host_sum == player_sum && host_sum < 21
			puts "You WIN!, #{name} is the BEST!" if host_sum < player_sum && host_sum < 21
			f_gameover=TRUE
		end
	end
puts "Do you want to play again? (Y/N)"
again=gets.chomp.downcase
end while again == "y"











