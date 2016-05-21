module TicTacToe
  class Game
    def initialize
      @humanMoves = []
      @computerMoves = []
      @dangerCombos = [[1, 2], [2, 3], [1, 3], [4, 5], [5, 6], [4, 6], [7, 8],
                      [8, 9], [7, 9], [1, 5], [5, 9], [3, 5], [5, 7], [1, 4], [1, 7], [4, 7],
                      [2, 5], [5, 8], [3, 6], [6, 9], [3, 9]]
    end

    def start_game
      @board = Board.new
      @player = Player.new
      @player.set_players
      if @player.computerChar == 'X'
        @board.update(5, @player.computerChar)
        @computerMoves << 5
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
      computer_turn
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

    def computer_turn
      puts "Computer's turn"
      if @humanMoves.length == 1
        if @board.grid[4].is_a?(Integer)
          computer_move(5)
        elsif @computerMoves == []
          computer_move(7)
        elsif (@humanMoves.include? 1) || (@humanMoves.include? 2) || (@humanMoves.include? 4)
          computer_move(9)
        elsif (@humanMoves.include? 9) || (@humanMoves.include? 8) || (@humanMoves.include? 6)
          computer_move(1)
        elsif @humanMoves.include? 7
          computer_move(3)
        elsif @humanMoves.include? 3
          computer_move 7
        end
      elsif @humanMoves.length >= 2
        if winning_move? == true
          win
        elsif danger_combos? == true
          defeat_danger
        else
          puts "Where should you move?"
        end
      end
      end

    def end_game
      @board.display
      puts "GAME OVER!! YOU LOSE!!"
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
      return true if @humanMoves.length + @computerMoves.length == 9
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
      if (@computerMoves.include? 1) && (@computerMoves.include? 2)
        computer_move(3) if @board.grid[2].is_a?(Integer)
      elsif (@computerMoves.include? 2) && (@computerMoves.include? 3)
        computer_move(1) if @board.grid[0].is_a?(Integer)
      elsif (@computerMoves.include? 1) && (@computerMoves.include? 3)
        computer_move(2) if @board.grid[1].is_a?(Integer)
      elsif (@computerMoves.include? 4) && (@computerMoves.include? 5)
        computer_move(6) if @board.grid[5].is_a?(Integer)
      elsif (@computerMoves.include? 5) && (@computerMoves.include? 6)
        computer_move(4) if @board.grid[3].is_a?(Integer)
      elsif (@computerMoves.include? 4) && (@computerMoves.include? 6)
        computer_move(5) if @board.grid[4].is_a?(Integer)
      elsif (@computerMoves.include? 7) && (@computerMoves.include? 8)
        computer_move(9) if @board.grid[8].is_a?(Integer)
      elsif (@computerMoves.include? 8) && (@computerMoves.include? 9)
        computer_move(7) if @board.grid[6].is_a?(Integer)
      elsif (@computerMoves.include? 7) && (@computerMoves.include? 9)
        computer_move(8) if @board.grid[7].is_a?(Integer)
      elsif (@computerMoves.include? 1) && (@computerMoves.include? 5)
        computer_move(9) if @board.grid[8].is_a?(Integer)
      elsif (@computerMoves.include? 5) && (@computerMoves.include? 9)
        computer_move(1) if @board.grid[0].is_a?(Integer)
      elsif (@computerMoves.include? 3) && (@computerMoves.include? 5)
        computer_move(7) if @board.grid[6].is_a?(Integer)
      elsif (@computerMoves.include? 5) && (@computerMoves.include? 7)
        computer_move(3) if @board.grid[2].is_a?(Integer)
      elsif (@computerMoves.include? 1) && (@computerMoves.include? 4)
        computer_move(7) if @board.grid[6].is_a?(Integer)
      elsif (@computerMoves.include? 1) && (@computerMoves.include? 7)
        computer_move(4) if @board.grid[3].is_a?(Integer)
      elsif (@computerMoves.include? 4) && (@computerMoves.include? 7)
        computer_move(1) if @board.grid[0].is_a?(Integer)
      elsif (@computerMoves.include? 2) && (@computerMoves.include? 5)
        computer_move(8) if @board.grid[7].is_a?(Integer)
      elsif (@computerMoves.include? 5) && (@computerMoves.include? 8)
        computer_move(2) if @board.grid[1].is_a?(Integer)
      elsif (@computerMoves.include? 3) && (@computerMoves.include? 6)
        computer_move(9) if @board.grid[8].is_a?(Integer)
      elsif (@computerMoves.include? 6) && (@computerMoves.include? 9)
        computer_move(3) if @board.grid[2].is_a?(Integer)
      elsif (@computerMoves.include? 3) && (@computerMoves.include? 9)
        computer_move(6) if @board.grid[5].is_a?(Integer)
    end
  end

    def defeat_danger
      if (@humanMoves.include? 1) && (@humanMoves.include? 2)
        computer_move 3 if @board.grid[2].is_a?(Integer)
      elsif (@humanMoves.include? 2) && (@humanMoves.include? 3)
        computer_move 1 if @board.grid[0].is_a?(Integer)
      elsif (@humanMoves.include? 1) && (@humanMoves.include? 3)
        computer_move 2 if @board.grid[1].is_a?(Integer)
      elsif (@humanMoves.include? 4) && (@humanMoves.include? 5)
        computer_move 6 if @board.grid[5].is_a?(Integer)
      elsif (@humanMoves.include? 5) && (@humanMoves.include? 6)
        computer_move 4 if @board.grid[3].is_a?(Integer)
      elsif (@humanMoves.include? 4) && (@humanMoves.include? 6)
        computer_move(5) if @board.grid[4].is_a?(Integer)
      elsif (@humanMoves.include? 7) && (@humanMoves.include? 8)
        computer_move(9) if @board.grid[8].is_a?(Integer)
      elsif (@humanMoves.include? 8) && (@humanMoves.include? 9)
        computer_move(7) if @board.grid[6].is_a?(Integer)
      elsif (@humanMoves.include? 7) && (@humanMoves.include? 9)
        computer_move(8) if @board.grid[7].is_a?(Integer)
      elsif (@humanMoves.include? 1) && (@humanMoves.include? 5)
        computer_move(9) if @board.grid[8].is_a?(Integer)
      elsif (@humanMoves.include? 5) && (@humanMoves.include? 9)
        computer_move(1) if @board.grid[0].is_a?(Integer)
      elsif (@humanMoves.include? 3) && (@humanMoves.include? 5)
        computer_move(7) if @board.grid[6].is_a?(Integer)
      elsif (@humanMoves.include? 5) && (@humanMoves.include? 7)
        computer_move(3) if @board.grid[2].is_a?(Integer)
      elsif (@humanMoves.include? 1) && (@humanMoves.include? 4)
        computer_move(7) if @board.grid[6].is_a?(Integer)
      elsif (@humanMoves.include? 1) && (@humanMoves.include? 7)
        computer_move(4) if @board.grid[3].is_a?(Integer)
      elsif (@humanMoves.include? 4) && (@humanMoves.include? 7)
        computer_move(1) if @board.grid[0].is_a?(Integer)
      elsif (@humanMoves.include? 2) && (@humanMoves.include? 5)
        computer_move(8) if @board.grid[7].is_a?(Integer)
      elsif (@humanMoves.include? 5) && (@humanMoves.include? 8)
        computer_move(2) if @board.grid[1].is_a?(Integer)
      elsif (@humanMoves.include? 3) && (@humanMoves.include? 6)
        computer_move(9) if @board.grid[8].is_a?(Integer)
      elsif (@humanMoves.include? 6) && (@humanMoves.include? 9)
        computer_move(3) if @board.grid[2].is_a?(Integer)
      elsif (@humanMoves.include? 3) && (@humanMoves.include? 9)
        computer_move(6) if @board.grid[5].is_a?(Integer)
      end
  end
end
end
