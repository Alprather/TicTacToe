module TicTacToe
  class Game
    def initialize
      @humanMoves = []
      @computerMoves = []

      @dangerCombos = [[1, 2, 3], [2, 3, 1], [1, 3, 2], [4, 5, 6], [5, 6, 4],
                      [4, 6, 5], [7, 8, 9], [8, 9, 7], [7, 9, 8], [1, 5, 9],
                      [5, 9, 1], [3, 5, 7], [5, 7, 3], [1, 4, 7], [1, 7, 4],
                      [4, 7, 1], [2, 5, 8], [5, 8, 2], [3, 6, 9], [6, 9, 3], [3, 9, 6]]
    end

    def start_game
      @board = Board.new
      @player = Player.new
      @player.set_players
      if @player.computerChar == 'X'
        @board.update(7, @player.computerChar)
        @computerMoves << 7
        take_turn
      else
        take_turn
      end
    end

    def take_turn
      puts "#{@player.name}, Enter a number between 1 and 9 to place #{@player.playerChar}"
      @board.display
      move = gets.chomp.to_i
      @board.update(move, @player.playerChar)
      @humanMoves << move
      if @player.computerChar == 'X'
        computer_turn_x
      else
        computer_turn_o
      end
    end

    def computer_move(move)
      @board.update(move, @player.computerChar)
      @computerMoves << move
      @board.display
      if winner? == true
        end_game
      else
      take_turn
    end
    end

    def computer_turn_o
      "Computer's turn"
      if is_free?(5)
        computer_move(5)
      else
        computer_move(9) if is_free?(9) && @humanMoves.include?(5)
      end
      win if winning_move?
      defeat_danger if danger_combos?
      computer_move(8) if is_free?(8) && @computerMoves.include?(5)
      computer_move(3) if is_free?(3)
      computer_move(7) if is_free?(7)
      take_turn

      # play 5,7,6,1 returns error with no move!!
    end

    def computer_turn_x
      puts "Computer's turn"

      end

    def end_game
      puts "GAME OVER!! YOU LOSE!!"
      @board.display
      @computerMoves.each do |move|
        puts "#{move}"
      end
      puts "Would you like to play again? yes/no"
      response = gets.chomp.downcase
      if response == "yes"
        TicTacToe::Game.new.start_game
      else
        puts "Goodbye"
      end
    end

    def winner?
      winningCombos = [[1, 2, 3], [4, 5, 6], [7, 8, 9], [1, 4, 7], [2, 5, 8],
                       [3, 6, 9], [1, 5, 9], [3, 5, 7]]
      winningCombos.each do |array|
        if (@computerMoves.include? (array[0])) && (@computerMoves.include? (array[1])) && (@computerMoves.include? (array[2]))
          return true
        end
      end
    end


    def draw?
      draw = true
      for i in 1..9
        draw = false if is_free?(i) == true
      end
      draw
    end

    def winning_move?
      @dangerCombos.each do |array|
        if (@computerMoves.include? (array[0])) && (@computerMoves.include? (array[1]))
          return true
        end
      end
    end

    def danger_combos?
      @dangerCombos.each do |array|
        if (@humanMoves.include? (array[0])) && (@humanMoves.include? (array[1]))
          return true
        end
      end
    end

    def win
      @dangerCombos.each do |array|
        if (@computerMoves.include? (array[0])) && (@computerMoves.include? (array[1]))
          computer_move(array[2]) if is_free?(array[2])
        end
      end
    end

    def defeat_danger
      @dangerCombos.each do |array|
        if (@humanMoves.include? (array[0])) && (@humanMoves.include? (array[1]))

          computer_move(array[2]) if is_free?(array[2])
        end
    end
  end

    def is_free? (move)
      return true if @board.grid[move - 1].is_a?(Integer)
    end

end
end
