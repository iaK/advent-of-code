defmodule AdventOfCode.Day2.Part1 do
  @addition 1
  @multiplication 2
  @stop 99
  @step 4

  def intcode(input, initial_state) do
    Enum.at(process(input, initial_state), 0)
  end

  def process(input, initial_state) do
    format_input(input)
      |> set_initial_state(initial_state)
      |> calculate_intcodes
  end

  defp set_initial_state(input, []) do
    input
  end

  defp set_initial_state(input, state) do
    List.replace_at(input, 1, Enum.at(state, 0)) |> List.replace_at(2, Enum.at(state, 1))
  end

  defp format_input(input) do
    input
      |> String.trim()
      |> String.split(",")
      |> Enum.map(&(elem(Integer.parse(&1),0)))
  end

  defp calculate_intcodes(codes) do
    calculate_intcodes(codes, 0)
  end

  defp calculate_intcodes(codes, position) do
    case Enum.at(codes, position) do
      @addition -> perform_addition(codes, position) |> calculate_intcodes(position + @step)
      @multiplication -> perform_multiplication(codes, position) |> calculate_intcodes(position + @step)
      @stop -> codes
    end
  end

  defp perform_addition(codes, position) do
    insert_code(codes, position, first_param(codes, position) + second_param(codes, position))
  end

  defp perform_multiplication(codes, position) do
    insert_code(codes, position, first_param(codes, position) * second_param(codes, position))
  end

  defp first_param(codes, position) do
    get_at_position(codes, position + 1)
  end

  defp second_param(codes, position) do
    get_at_position(codes, position + 2)
  end

  defp insert_code(codes, position, code) do
    List.replace_at(codes, Enum.at(codes, position + 3), code)
  end

  defp get_at_position(codes, position) do
     Enum.at(codes, Enum.at(codes, position))
  end

end
