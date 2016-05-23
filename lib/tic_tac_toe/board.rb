module TicTacToe
  class Board
    attr_accessor :grid
    def initialize
      @grid = [1, 2, 3, 4, 5, 6, 7, 8, 9]
      @displayGrid = [" ", " ", " ", " ", " ", " ", " ", " ", " "]
    end

    def display
      puts " "
      puts "1 | 2 | 3          #{@displayGrid[0]} | #{@displayGrid[1]} | #{@displayGrid[2]}"
      puts "----------        -----------"
      puts "4 | 5 | 6   ->>    #{@displayGrid[3]} | #{@displayGrid[4]} | #{@displayGrid[5]}"
      puts "----------        -----------"
      puts "7 | 8 | 9          #{@displayGrid[6]} | #{@displayGrid[7]} | #{@displayGrid[8]}"
    end


    def update(move, code)
        if @grid[move - 1].is_a?(Integer)
          @grid[move - 1] = code
          @displayGrid[move-1] = code
        else
          puts "Invalid move, try again"
        end
    end
  end
end
