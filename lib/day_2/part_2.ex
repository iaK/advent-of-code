defmodule AdventOfCode.Day2.Part2 do
  @addition 1
  @multiplication 2
  @stop 99
  @step 4
  @target 19690720

  def intcode(input) do
    format_input(input)
      |> calculate_intcodes_recursive
  end

  defp format_input(input) do
    input
      |> String.trim()
      |> String.split(",")
      |> Enum.map(&(elem(Integer.parse(&1),0)))
    end

    defp calculate_intcodes_recursive(codes, state \\ [37,48]) do
      codes_with_applied_state = set_state(state, codes)

      case calculate_intcodes(codes_with_applied_state) |> Enum.at(0) do
        @target -> 100 * Enum.at(state, 0) + Enum.at(state, 1)
        _ -> calculate_intcodes_recursive(codes, tick_state(state))
      end
    end

    def tick_state(state) do
      case Enum.at(state, 0) do
        99 -> [0, Enum.at(state,1) + 1]
        _ -> [Enum.at(state, 0) + 1, Enum.at(state,1)]
      end
    end

    defp calculate_intcodes(codes, position \\ 0) do
      case Enum.at(codes, position) do
        @addition -> perform_addition(codes, position) |> calculate_intcodes(position + @step)
        @multiplication -> perform_multiplication(codes, position) |> calculate_intcodes(position + @step)
        @stop -> codes
      end
    end

    defp set_state(state, codes) do
      List.replace_at(codes, 1, Enum.at(state, 0))
        |> List.replace_at(2, Enum.at(state, 1))
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
