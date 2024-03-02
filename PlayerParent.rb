class PlayerParent

    def PlayerParent.new(*args)
        if self == PlayerParent
            raise "PlayerParent is an abstract class and cannot be instantiated"
        else
            super
        end
    end

    def setup(num_players, index, suspects, locations, weapons)
        raise "PlayerParent is an abstract class and setup cannot be called"
    end

    def setCard(card)
        raise "PlayerParent is an abstract class and setCard cannot be called"
    end

    def canAnswer(i, g)
        raise "PlayerParent is an abstract class and canAnswer cannot be called"
    end

    def getGuess
        raise "PlayerParent is an abstract class and getGuess cannot be called"
    end

    def receiveInfo(i, c)
        raise "PlayerParent is an abstract class and receiveInfo cannot be called"
    end

end