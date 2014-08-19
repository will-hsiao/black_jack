
#A new card
card_suite=["spade", "heart", "diamond", "club"]
card_rank=["ace", 2, 3, 4, 5, 6, 7, 8, 9, 10, "queen", "king", "jack"]
card_new=card_suite.product(card_rank)

def shuffle(card)
	card_shuffle=[]
	begin
 		c=card.sample
 		card_shuffle<< c
 		card.delete(c)
 	end while !(card.empty?)
 	return card_shuffle

 end

 def calculate(card)
 	sum=0
 	ace_card=0
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
 			ace_card+=1
 		end
 	end
 	sum=calculate_ace(sum, ace_card) if ace_card >0
 	return sum	
 end

 def calculate_ace(sum, ace_card)
 	puts "#{sum}, ace=#{ace_card}"
 	 if ace_card==4
 		sum+=13
 		if sum >21
 			sum=sum-13+4
 		end
 	elsif ace_card==3
 		sum+=21
 		if sum > 21
 			sum=sum-21+12
 			if sum >21
 				sum=sum-12+3
 			end
 		end
 	elsif ace_card==2
 		sum +=20
 		if sum > 21
 			sum=sum-20+11
 			if sum >21
 				sum=sum-11+2
 			end
 		end
 	elsif ace_card==1
 		sum+=10
 		if sum>21
 			sum=sum-10+1
 		end
 	end
 	return sum
 end

#Shuffle Cards
card_shuffle = shuffle(card_new)
p card_shuffle

#Welcome
puts "Welcome to Black Jack!"
puts "You name?"
#name=gets.chomp
#puts "Welcome #{name} !"

#Dispatch Cards
player_card=[]
host_card=[]
player_card << card_shuffle.pop
host_card << card_shuffle.pop

	
	player_card << card_shuffle.pop
	
	begin
		player_sum=  calculate(player_card)
		puts "Your card: #{player_card} with #{player_sum} points"
		if player_sum>21
			puts "You busted!"
			break
		elsif player_sum==21
		puts "You got Blackjack. You WIN!"
		else
			puts "Hit or Stay? (h/s)"
			action=gets.chomp.downcase
			if action=="h"
				player_card << card_shuffle.pop 
			end
		end
	end while action == "h"

	host_card << card_shuffle.pop
	
	loop do
		host_sum=calculate(host_card)
		puts "Host's card: #{host_card} with #{host_sum} points"
		if host_sum>21
			puts "Host busted!"
			break
		elsif host_sum==21
			puts "Host got Blackjack. You LOOSE!"
			break
		elsif host_sum<17
			host_card << card_shuffle.pop
		elsif host_sum > player_sum
			puts "Host win! You LOOSE!"
			break
		elsif host_sum == player_sum
			puts "You and Host are even!"
			break
		else 
			puts "You WIN!"
			break
		end
	end










