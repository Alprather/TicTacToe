require "spec_helper"

module TicTacToe
  describe Player do

    context "#initialize" do
      it "initializes player" do
        expect { Player.new  }.to_not raise_error
      end
    end

  end
end
