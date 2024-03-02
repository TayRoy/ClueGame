class Card

    attr_reader :type, :value

    def initialize(type, value)
        #this method simply initializes the Card's values
        @type = type
        @value = value
    end

end