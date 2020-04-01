defmodule TextClient.Player do
  alias TextClient.{Mover, Prompter, State, Summary}

  def play(%State{tally: %{game_state: :won}}) do
    exit_with_message("Wow! Great job! You figured out this one.")
  end

  def play(%State{tally: %{game_state: :lost}}) do
    exit_with_message("Ops! You not won this time. Maybe in the next one.")
  end

  def play(game = %State{tally: %{game_state: :already_used}}) do
    continue_with_message(game, "It seems that you already used this letter :thinking_face:")
  end

  def play(game = %State{tally: %{game_state: :good_guess}}) do
    continue_with_message(game, "Nice one! Keep going.")
  end

  def play(game = %State{tally: %{game_state: :bad_guess}}) do
    continue_with_message(game, "Nope! It's not have this letter. Try again")
  end

  def play(game) do
    continue(game)
  end

  defp continue_with_message(game, message) do
    IO.puts(message)
    continue(game)
  end

  defp continue(game) do
    game
    |> Summary.display()
    |> Prompter.accept_move()
    |> Mover.make_move()
    |> play()
  end

  defp exit_with_message(message) do
    IO.puts(message)
    exit(:normal)
  end
end
