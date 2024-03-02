require_relative "PlayerParent"
class Player < PlayerParent

    attr_accessor :hand

    def setup(num_players, index, suspects, locations, weapons)
        #sets up the player with the necessary cards and player info
        @num_players = num_players
        @index = index
        @suspects = suspects.clone
        @locations = locations.clone
        @weapons = weapons.clone
        @hand = Array.new
    end

    def setCard(card)
        #deals a card and removes it from their potential remaining guesses
        @hand << card
        receiveInfo(@index, card)
    end

    def canAnswer(i, g)
        #will return the card in their hand if they can answer the suggestion
        for curr in 0..@hand.size-1 do
            if @hand[curr].value == g.person.value
                return @hand[curr]
            elsif @hand[curr].value == g.place.value
                return @hand[curr]
            elsif @hand[curr].value == g.weapon.value
                return @hand[curr]
            end
        end
        return nil
    end

    def getGuess
        #will make an accusation if they only have 1 card remaining for each remaining card type
        if @suspects.size == 1 && @locations.size == 1 && @weapons.size == 1
            my_guess = Guess.new(@suspects[0], @locations[0], @weapons[0], true)
        else
            my_guess = Guess.new(@suspects[rand(@suspects.size)], @locations[rand(@locations.size)], @weapons[rand(@weapons.size)], false)
        end
    end

    def receiveInfo(i, c)
        #will remove the card from their list of potential answers
        if c.type == :person
            @suspects.delete(c)
        elsif c.type == :place
            @locations.delete(c)
        elsif c.type == :weapon
            @weapons.delete(c)
        end
    end


end
