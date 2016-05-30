module TicTacToe
  class Player
    attr_accessor :name, :player_char, :computer_char
    def initialize
    		@name = name
        @player_char = player_char
        @computer_char = computer_char
    end

    def set_players
      puts "WELCOME TO TIC TAC TOE"
      puts "***********************"
      puts "What is your name?".blue
      @name = gets.chomp.capitalize
      puts "Would you like to go first? Yes/No".blue
      response = gets.chomp.downcase
        if response == "yes"
          @player_char = "X"
          @computer_char = "O"
        elsif response == "no"
          @player_char = "O"
          @computer_char = "X"
        else
          puts "Error: Invalid resopnse"
          set_players
        end
    end

  end
end
