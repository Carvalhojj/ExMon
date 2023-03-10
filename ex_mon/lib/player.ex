defmodule ExMon.Player do
  @max_life 100
  @required_keys [:life, :moves, :name]
  defstruct @required_keys

  def build(name, move_avg, move_heal, move_rnd) do
    %ExMon.Player{
      life: @max_life,
      moves: %{
        move_avg: move_avg,
        move_heal: move_heal,
        move_rnd: move_rnd
      },
      name: name
    }
  end
end
