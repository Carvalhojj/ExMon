defmodule ExMonTest do
  use ExUnit.Case
  alias ExMon.Player
  import ExUnit.CaptureIO

  describe "create_player/4" do
    test "returns a player" do
      expected_response = %Player{
        life: 100,
        moves: %{
          move_avg: :chute,
          move_heal: :cura,
          move_rnd: :soco
        },
        name: "Guilherme"
      }

      assert expected_response == ExMon.create_player("Guilherme", :chute, :soco, :cura)
    end
  end

  describe "start_game/1" do
    test "when the game is started, returns a massage" do
      player = Player.build("Guilherme", :chute, :soco, :cura)

      messages =
        capture_io(fn ->
          assert ExMon.start_game(player) == :ok
        end)

        assert messages =~ "The game is started!"
        assert messages =~ "status: :started"
        assert messages =~ "turn: :player"
    end
  end

  describe "make_move/1" do
    setup do
      player = Player.build("Guilherme", :chute, :soco, :cura)

      capture_io(fn ->
        ExMon.start_game(player)
      end)

      :ok
    end

    test "when the move is valid, do the move and the computer makes a move" do
      messages =
        capture_io(fn ->
          ExMon.make_move(:chute)
        end)

      assert messages =~ "The Player attacked the computer"
      assert messages =~ "It's computer turn"
      assert messages =~ "It's player turn"
      assert messages =~ "status: :continue"
    end

    test "when the move is invalid, return an error message" do
      messages =
        capture_io(fn ->
          ExMon.make_move(:voadora)
        end)

      assert messages =~ "Invalid move: voadora"
    end
  end
end
