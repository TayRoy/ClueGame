require_relative "PlayerParent"
class InteractivePlayer < PlayerParent

    attr_accessor :hand

    def setup(num_players, index, suspects, locations, weapons)
        @num_players = num_players
        @index = index
        #deep copy the arrays
        @suspects = suspects.clone
        @locations = locations.clone
        @weapons = weapons.clone
        @hand = Array.new
        #print off the cards
        puts "Here are the names of all the suspects:"
        for i in 0..@suspects.size-1 do
            print "#{@suspects[i].value}"
            if i != @suspects.size-1
                print ", "
            else
                puts ""
            end
        end
        puts "Here are the names of all the locations:"
        for i in 0..@locations.size-1 do
            print "#{@locations[i].value}"
            if i != @locations.size-1
                print ", "
            else
                puts ""
            end
        end
        puts "Here are the names of all the weapons:"
        for i in 0..@weapons.size-1 do
            print "#{@weapons[i].value}"
            if i != @weapons.size-1
                print ", "
            else
                puts ""
            end
        end
    end

    def setCard(card)
        #adds card to hand
        @hand << card
    end

    def canAnswer(i, g)
        #determines whether the player can respond to another player's guess. 
        #Will return nil if the player cannot respond, will return the or one of answerable card(s)
        found = false
        answered_cards = Array.new
        #adds answerable cards into an array
        for curr in 0..@hand.size-1 do
            if @hand[curr].value == g.person.value
                answered_cards << @hand[curr]
            elsif @hand[curr].value == g.place.value
                answered_cards << @hand[curr]
            elsif @hand[curr].value == g.weapon.value
                answered_cards << @hand[curr]
            end
        end
        #asks for prompt if >1 answerable card
        if answered_cards.size == 0
            puts "Player #{i} asked you about suggestion: #{g.person.value} in #{g.place.value} with the #{g.weapon.value}, but you couldn't answer."
            return nil
        elsif answered_cards.size == 1
            puts "Player #{i} asked you about suggestion: #{g.person.value} in #{g.place.value} with the #{g.weapon.value}, you only have one card, #{answered_cards[0].value}, showed it to them."
            return answered_cards[0]
        else
            puts "Player has multiple cards to respond to a suggestion:"
            puts "Player #{i} asked you about suggestion: #{g.person.value} in #{g.place.value} with the #{g.weapon.value}. Which do you show?"
            for i in 0..answered_cards.size-1 do
                puts "#{i+1} : #{answered_cards[i].value}"
            end
            card_answer = nil
            in_list = false
            while in_list == false
                chosen_card = gets.chomp.strip.to_i - 1
                for k in 0..answered_cards.size-1 do
                    if k == chosen_card
                        in_list = true
                        card_answer = answered_cards[k]
                    end
                end
                if in_list == false
                    puts "Option not available. Select # from 0-#{answered_cards.size-1}"
                end
            end
            return card_answer
        end
    end

    def getGuess
        #makes a guess dependent on user input, suggestion or accusation. Returns the guess.
        puts "It is your turn."
        puts "Which person do you want to suggest?"
        for i in 0..@suspects.size-1 do
            puts "#{i+1} : #{@suspects[i].value}"
        end
        in_list = false
        suspect_answer = nil
        while in_list == false
            chosen_person = gets.chomp.strip.to_i - 1
            for k in 0..@suspects.size-1 do
                if k == chosen_person
                    in_list = true
                    suspect_answer = @suspects[k]
                end
            end
            if in_list == false
                puts "Option not available. Select # from 0-#{@suspects.size-1}"
            end
        end
        

        puts "Which location do you want to suggest?"
        for i in 0..@locations.size-1 do
            puts "#{i+1} : #{@locations[i].value}"
        end
        in_list = false
        location_answer = nil
        while in_list == false
            chosen_location = gets.chomp.strip.to_i - 1
            for k in 0..@locations.size-1 do
                if k == chosen_location
                    in_list = true
                    location_answer = @locations[k]
                end
            end
            if in_list == false
                puts "Option not available. Select # from 0-#{@locations.size-1}"
            end
        end
        
        puts "Which weapon do you want to suggest?"
        for i in 0..@weapons.size-1 do
            puts "#{i+1} : #{@weapons[i].value}"
        end
        in_list = false
        weapon_answer = nil
        while in_list == false
            chosen_weapon = gets.chomp.strip.to_i - 1
            for k in 0..@weapons.size-1 do
                if k == chosen_weapon
                    in_list = true
                    weapon_answer = @weapons[k]
                end
            end
            if in_list == false
                puts "Option not available. Select # from 0-#{@weapons.size-1}"
            end
        end

        puts "Is this an accusation (Y/N)?"
        acceptable = false
        while acceptable == false
            is_accusation = gets.chomp.upcase.strip
            if is_accusation == "Y"
                chosen_accusation = true
                acceptable = true
            elsif is_accusation == "N"
                chosen_accusation = false
                acceptable = true
            end
        end

        my_guess = Guess.new(suspect_answer, location_answer, weapon_answer, chosen_accusation)

    end

    def receiveInfo(i, c)
        #responds whether a suggestion could be refuted by the player i
        if c != nil
            puts "Player #{i} refuted your suggestion by showing you #{c.value}."
        else
            puts "No one could refute your suggestion."
        end
    end

end
