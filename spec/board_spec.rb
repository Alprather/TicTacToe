require "spec_helper"

module TicTacToe
  describe Board do

    context "#initialize" do
      it "initializes the board" do
        expect { Board.new }.to_not raise_error
      end
      end

      context "#grid" do
        it "returns the grid" do
          board = Board.new
          expect(board.grid).to eq [1, 2, 3, 4, 5, 6, 7, 8, 9]
        end
      end

  end
end
