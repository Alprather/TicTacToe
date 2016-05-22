module TicTacToe
  class Game
    def initialize
      @humanMoves = []
      @computerMoves = []

      @dangerCombos = [[1, 2, 3], [2, 3, 1], [1, 3, 2], [4, 5, 6], [5, 6, 4],
                      [4, 6, 5], [7, 8, 9], [8, 9, 7], [7, 9, 8], [1, 5, 9], [9, 1, 5],
                      [5, 9, 1], [3, 7, 5], [3, 5, 7], [5, 7, 3], [1, 4, 7], [1, 7, 4],
                      [4, 7, 1], [2, 5, 8], [5, 8, 2], [2, 8, 5], [3, 6, 9], [6, 9, 3], [3, 9, 6]]
    end

    def start_game
      @board = Board.new
      @player = Player.new
      @player.set_players
      if @player.computerChar == 'X'
        puts "Computer's turn"
        computer_turn_x
      else
        take_turn
        puts "Computer's turn"
        computer_turn_o
      end
    end

    def take_turn
      puts "#{@player.name}, Enter a number between 1 and 9 to place #{@player.playerChar}"
      @board.display
      move = gets.chomp.to_i
      @board.update(move, @player.playerChar)
      @humanMoves << move
      if winner? == true || draw? == true
        end_game
      else
        puts "Computer's turn"
      end
    end

    def computer_move(move)
      @board.update(move, @player.computerChar)
      @computerMoves << move
      @board.display
      if winner? == true
        end_game
      elsif draw? == true
        end_game
      else
        take_turn
    end
    end

    def computer_turn_o
      if is_free?(5)
        computer_move(5)
        computer_move(8) if is_free?(8) && @humanMoves.include?(3) && @humanMoves.include?(7)
        computer_move(8) if is_free?(8) && @humanMoves.include?(1) && @humanMoves.include?(9)
      else
        computer_move(9) if is_free?(9)
      end
        movePriorities = [3, 7, 1, 2, 4, 6]
        movePriorities.each do |move|
          win if winning_move?
          defeat_danger if danger_combos? == true
          computer_move(move) if is_free?(move)
        end
    end

    def computer_turn_x
      computer_move(7)
      if @humanMoves.include?(5)
        computer_move(3)
        until draw? == true || winner? == true
          win if winning_move?
          defeat_danger if danger_combos?
        end
      elsif @humanMoves.include?(2)
        computer_move(9)
        computer_move(5) if @humanMoves.include?(8)
        win
      elsif @humanMoves.include?(8) || @humanMoves.include?(9)
        computer_move(1)
        is_free?(3) ? computer_move(3) : computer_move(9)
        win
      else
        computer_move(9)
        computer_move(1) if @humanMoves.include?(3) || @humanMoves.include?(6)
        computer_move(3) if @humanMoves.include?(1) || @humanMoves.include?(4)
        win if winning_move?
      end
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
      return true if @computerMoves.length + @humanMoves.length == 9
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
