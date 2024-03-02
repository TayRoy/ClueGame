class Model

    attr_accessor :players

    @@winning_suspect = nil
    @@winning_location = nil
    @@winning_weapon = nil

    def initialize(suspects, locations, weapons)
        #initializes values
        @suspects = suspects
        @locations = locations
        @weapons = weapons
        @players = nil
        @deck = nil
    end

    def setPlayers(players)
        #sets up the players with the list of cards and other player info
        @players = players
        for i in 0..@players.size-1
            @players[i].setup(@players.size, i, @suspects, @locations, @weapons)
        end
    end

    def setupCards
        #selects the winning cards, shuffles the cards and deals the cards to each player iteratively
        @@winning_suspect = @suspects.delete_at(rand(@suspects.size))
        @@winning_location = @locations.delete_at(rand(@locations.size))
        @@winning_weapon = @weapons.delete_at(rand(@weapons.size))
        @deck = @suspects + @locations + @weapons
        @deck = @deck.shuffle
        index = 0
        while @deck.size > 0
            @players[index].setCard(@deck.shift)
            if @players[index].instance_of?(InteractivePlayer)
                puts "You received the card #{players[index].hand.last.value}."
            end
            index = (index + 1) % @players.size
        end
    end
        
    def play
        over = false #game is over
        curr = 0 #active player index
        while over == false
            puts "Current turn: #{curr}"
            guess = @players[curr].getGuess
            if guess.accusation
                #will complete the game if the accusation is correct or
                #will boot the player from the game if incorrect & show the player's cards to the remaining players
                puts "Player #{curr}: Accusation: #{guess.person.value} in #{guess.place.value} with the #{guess.weapon.value}."
                if guess.person == @@winning_suspect && guess.place == @@winning_location && guess.weapon == @@winning_weapon
                    puts "Player #{curr} won the game."
                    over = true
                else
                    puts "Player #{curr} made a bad accusation and was removed from the game."
                    for i in 0..@players.size-2 do
                        for j in 0..@players[curr].hand.size-1 do
                            @players[i].receiveInfo(i, @players[curr].hand[j])
                        end
                    end
                    @players.delete_at(curr)
                end
            else
                #will ask each player in order if they can refute the suggestion
                puts "Player #{curr}: Suggestion: #{guess.person.value} in #{guess.place.value} with the #{guess.weapon.value}."
                guess_curr = (curr + 1) % @players.size
                guess_found = false
                while guess_curr != curr && guess_found == false
                    puts "Asking player #{guess_curr}"
                    guess_card = @players[guess_curr].canAnswer(curr, guess)
                    if guess_card != nil
                        puts "Player #{guess_curr} answered."
                        @players[curr].receiveInfo(guess_curr, guess_card)
                        guess_found = true
                    else
                        guess_curr = (guess_curr + 1) % @players.size
                    end
                end
                if guess_found == false
                    puts "No one could answer."
                end             
            end
            curr = (curr + 1) % @players.size
        end
    end

end