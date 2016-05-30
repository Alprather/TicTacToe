module TicTacToe
  class Game
    def initialize
      @human_moves = []
      @computer_moves = []

      @dangerCombos = [[1, 2, 3], [2, 3, 1], [1, 3, 2], [4, 5, 6], [5, 6, 4],
                      [4, 6, 5], [7, 8, 9], [8, 9, 7], [7, 9, 8], [1, 5, 9], [9, 1, 5],
                      [5, 9, 1], [3, 7, 5], [3, 5, 7], [5, 7, 3], [1, 4, 7], [1, 7, 4],
                      [4, 7, 1], [2, 5, 8], [5, 8, 2], [2, 8, 5], [3, 6, 9], [6, 9, 3], [3, 9, 6]]
    end

    def start_game
      clear_screen
      @board = Board.new
      @player = Player.new
      @player.set_players
      clear_screen
      if @player.computerChar == 'X'
        computer_turn_x
      else
        human_turn
        computer_turn_o
      end
    end

    def human_turn
      clear_screen
      puts "#{@player.name}, Enter a number between 1 and 9 to place #{@player.playerChar}".blue
      puts " "
      @board.display
      move = gets.chomp.to_i
      if is_free?(move) && move > 0 && move < 10
        @board.update(move, @player.playerChar)
        @human_moves << move
          if winner? == true || draw? == true
            end_game
          end
      else
        human_turn
      end
    end

    def computer_move(move)
      @board.update(move, @player.computerChar)
      @computer_moves << move
      if winner? == true
        end_game
      elsif draw? == true
        end_game
      else
        human_turn
      end
    end

    def computer_turn_o
      if is_free?(5)
        computer_move(5)
        computer_move(8) if is_free?(8) && @human_moves.include?(3) && @human_moves.include?(7)
        computer_move(8) if is_free?(8) && @human_moves.include?(1) && @human_moves.include?(9)
      else
        computer_move(9) if is_free?(9)
      end
        move_priorities = [3, 7, 1, 2, 4, 6, 8]
        move_priorities.each do |move|
          until winning_move? == false && danger_combos? == false
            win if winning_move?
            block if danger_combos?
          end
          computer_move(move) if is_free?(move)
        end
      end

    def computer_turn_x
      computer_move(7)
      if @human_moves.include?(5)
        computer_move(3)
        until draw? == true || winner? == true
         win if winning_move?
         block if danger_combos?
       end
     elsif @human_moves.include?(2)
        computer_move(9) if is_free?(9)
        computer_move(5) if @human_moves.include?(8)
        win
      elsif @human_moves.include?(8) or @human_moves.include?(9)
        computer_move(1) if is_free?(1)
        win if winning_move?
        computer_move(3) if is_free?(3)
        win if winning_move?
      else
        computer_move(9)
        win if winning_move?
        computer_move(5)
        win if winning_move?
        block if danger_combos?
        computer_move(4) if is_free?(4)
        computer_move(6) if is_free?(6)

      end
    end

    def end_game
      clear_screen
      if winner? == true
        puts "GAME OVER!! YOU LOSE!!".red
        @board.display
      else
        puts "IT'S A DRAW!!...  But good luck beating me!".red
        @board.display
      end
      puts "Would you like to play again, #{@player.name}? yes/no".blue
      response = gets.chomp.downcase
      if response == "yes"
        Game.new.start_game
      else
        abort("Goodbye")
      end
    end

    def winner?
      winningCombos = [[1, 2, 3], [4, 5, 6], [7, 8, 9], [1, 4, 7], [2, 5, 8],
                       [3, 6, 9], [1, 5, 9], [3, 5, 7]]
      winningCombos.each do |array|
        if (@computer_moves.include? (array[0])) && (@computer_moves.include? (array[1])) && (@computer_moves.include? (array[2]))
          @board.grid[array[0]-1] = @player.computerChar.red
          @board.grid[array[1]-1] = @player.computerChar.red
          @board.grid[array[2]-1] = @player.computerChar.red
          return true
        end
      end
      return false
    end


    def draw?
      return true if @computer_moves.length + @human_moves.length == 9
    end

    def winning_move?
      @dangerCombos.each do |array|
        if (@computer_moves.include? (array[0])) && (@computer_moves.include? (array[1])) && is_free?(array[2])
          return true
        end
      end
      return false
    end

    def danger_combos?
      @dangerCombos.each do |array|
        if (@human_moves.include? (array[0])) && (@human_moves.include? (array[1])) && is_free?(array[2])
          return true
        end
      end
      return false
    end

    def win
      @dangerCombos.each do |array|
        if (@computer_moves.include? (array[0])) && (@computer_moves.include? (array[1]))
            if is_free?(array[2])
                computer_move(array[2])
                return
            end
        end
      end
    end

    def block
      @dangerCombos.each do |array|
        if (@human_moves.include? (array[0])) && (@human_moves.include? (array[1]))
           if is_free?(array[2])
             computer_move(array[2])
          return
          end
        end
      end
    end

    def is_free? (move)
      return true if @board.grid[move - 1].is_a?(Integer)
    end

end
end
