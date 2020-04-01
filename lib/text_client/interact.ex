defmodule TextClient.Interact do
  def start() do
    Hangman.new_game()
    |> setup_state()
  end

  def setup_state(game) do
    %TextClient.State{
      game_service: game,
      tally: Hangman.tally(game)
    }
  end

  def play(state) do
    play(state)
  end
end
