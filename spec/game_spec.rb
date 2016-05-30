require "spec_helper"

module TicTacToe
  describe Game do

    context "#initialize" do
      it "initializes game" do
        expect { Game.new  }.to_not raise_error
      end
    end

    context "#danger_combos" do
      it "returns an array of ordered winning combos" do
        game = Game.new
        expect(danger_combos).to eq [[1, 2, 3], [2, 3, 1], [1, 3, 2], [4, 5, 6], [5, 6, 4],
                        [4, 6, 5], [7, 8, 9], [8, 9, 7], [7, 9, 8], [1, 5, 9], [9, 1, 5],
                        [5, 9, 1], [3, 7, 5], [3, 5, 7], [5, 7, 3], [1, 4, 7], [1, 7, 4],
                        [4, 7, 1], [2, 5, 8], [5, 8, 2], [2, 8, 5], [3, 6, 9], [6, 9, 3], [3, 9, 6]]
    end
  end

  end
end
