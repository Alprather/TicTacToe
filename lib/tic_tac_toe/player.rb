module TicTacToe
  class Player
    attr_accessor :name, :playerChar, :computerChar
    def initialize(name)
    		@name = name
        @playerChar = playerChar
        @computerChar = computerChar
    end

    def set_players(name)
      puts "Would you like to go first? Yes/No"
      response = gets.chomp.downcase
        if response == "yes"
          @playerChar = "X"
          @computerChar = "O"
        elsif response == "no"
          @playerChar = "O"
          @computerChar = "X"
        else
          puts "Error: Invalid resopnse"
          set_players
        end
    end

  end
end
