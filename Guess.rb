class Guess

    attr_reader :person, :place, :weapon, :accusation

    def initialize(person, place, weapon, accusation)
        #this method simply initializes the Guess' values
        @person = person
        @place = place
        @weapon = weapon
        @accusation = accusation
    end

    def isAccusation
        #this method returns the accusation variable
        return @accusation
    end

end
