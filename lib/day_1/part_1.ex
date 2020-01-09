defmodule AdventOfCode.Day1.Part1 do
  alias AdventOfCode.Day1.FuelUsageCalculator

  def fuel_requirement(input) do
    input
      |> format_input
      |> calculate_fuel_usage
  end

  defp calculate_fuel_usage(fuel) do
    fuel
      |> Enum.reduce(0, fn (mass, acc) -> acc + FuelUsageCalculator.usage(mass) end)
  end

  defp format_input(input) do
    input
     |> String.trim
     |> String.split("\r\n")
     |> Enum.map(&(elem(Integer.parse(&1), 0)))
  end
end
