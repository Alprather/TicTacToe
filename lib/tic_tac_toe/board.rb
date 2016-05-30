module TicTacToe
  class Board
    attr_accessor :grid
    def initialize
      @grid = [1, 2, 3, 4, 5, 6, 7, 8, 9]
      @winningCombo = []
    end

    def display
      puts "***********************************"
      puts "********   TIC TAC TOE   **********"
      puts "***********************************"
      puts "** ----------------------------- **"
      puts "**|                             |**"
      puts "**|          " "#{@grid[0]}" " | " "#{@grid[1]}" " | " "#{@grid[2]}" "          |**"
      puts "**|         ----------          |**"
      puts "**|          "  "#{@grid[3]}" " | " "#{@grid[4]}" " | " "#{@grid[5]}" "          |**"
      puts "**|         ----------          |**"
      puts "**|          " "#{@grid[6]}" " | " "#{@grid[7]}" " | " "#{@grid[8]}" "          |**"
      puts "**|                             |**"
      puts "** ----------------------------- **"
      puts "***********************************"
      puts "***********************************"
    end

    def update(move, code)
        if @grid[move - 1].is_a?(Integer)
          @grid[move - 1] = code.green
        else
          puts "Invalid move, try again"
        end
    end

  end
end
