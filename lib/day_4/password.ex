defmodule AdventOfCode.Day4.Password do
  def count_combinations_group_insensitive(low, high) do
    count_combinations(normalize(low), high, true, 0)
  end

  def all_possible_combinations(low, high) do
    count_combinations(normalize(low), high, false, 0)
  end

  def count_combinations(number, roof, group_sensitive \\ false, step \\ 0) do
    count = case is_valid_combination?(number, group_sensitive) do
      true -> step + 1
      false -> step
    end

    case number < roof do
      true -> count_combinations(increment(number), roof, group_sensitive, count)
      false -> step
    end
  end

  def increment(number) do
    number + 1 |> normalize
  end

  def is_valid_combination?(number, group_sensitive) do
    case group_sensitive do
      true -> is_valid_combination_group_sensitive?(number)
      false -> is_valid_combination?(number)
    end
  end

  def is_valid_combination?(number) when is_integer(number) do
    number
      |> int_to_string_list
      |> Enum.map(&Integer.parse(&1))
      |> Enum.map(&(elem(&1, 0)))
      |> is_valid_combination?
  end

  def is_valid_combination?([a, a, _, _, _, _]), do: true
  def is_valid_combination?([_, b, b, _, _, _]), do: true
  def is_valid_combination?([_, _, c, c, _, _]), do: true
  def is_valid_combination?([_, _, _, d, d, _]), do: true
  def is_valid_combination?([_, _, _, _, e, e]), do: true
  def is_valid_combination?(_), do: false

  def is_valid_combination_group_sensitive?(number) when is_integer(number) do
    number
      |> int_to_string_list
      |> Enum.reduce([nil,[0]],fn (number, [head, [matches | carry]]) ->
          case number == head do
            true -> [number, [matches + 1 | carry]]
            false -> [number, [1, matches | carry]]
          end
        end)
      |> Enum.at(1)
      |> Enum.member?(2)
  end

  def int_to_string_list(int) do
    int
      |> to_string
      |> String.split("")
      |> Enum.reject(&(&1 == ""))
  end

  def normalize(sum) when is_integer(sum) do
    to_string(sum) |> normalize()
  end

  def normalize(string) do
    {int, _} = string
      |> String.split("")
      |> Enum.reject(&(&1 == ""))
      |> Enum.reduce([],fn (number, carry) ->
        normalize(number, carry)
      end)
      |> Enum.at(1)
      |> Enum.reverse
      |> Enum.join
      |> Integer.parse

    int
  end

  def normalize(number, []) do
    {int, _} = Integer.parse(number)
    [int, [int]]
  end

  def normalize(number, [highest, list]) do
    {int, _} = Integer.parse(number)

    case int < highest do
        true -> [highest, [highest | list]]
        false -> [int, [int | list]]
    end
  end
end
