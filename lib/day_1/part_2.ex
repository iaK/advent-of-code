defmodule AdventOfCode.Day1.Part2 do
  alias AdventOfCode.Day1.FuelUsageCalculator

  def fuel_requirement(input) do
    input
      |> format_input
      |> fuel_usage
  end

  defp fuel_usage(modules) do
    modules
      |> Enum.reduce(0, fn (module, acc) -> acc + calculate_fuel_usage_recursive(module) end)
  end

  defp calculate_fuel_usage_recursive(mass) do
    calculate_fuel_usage_recursive(mass, [0])
  end

  defp calculate_fuel_usage_recursive(0, carry) do
    carry |> Enum.sum
  end

  defp calculate_fuel_usage_recursive(mass, carry) do
    usage = FuelUsageCalculator.usage(mass)
    calculate_fuel_usage_recursive(usage, [usage | carry])
  end

  defp format_input(input) do
    input
     |> String.trim
     |> String.split("\r\n")
     |> Enum.map(&(elem(Integer.parse(&1), 0)))
  end
end
