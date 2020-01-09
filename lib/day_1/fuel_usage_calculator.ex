defmodule AdventOfCode.Day1.FuelUsageCalculator do
  def usage(mass) do
    usage = Integer.floor_div(mass, 3) - 2

    case usage <= 0 do
      true -> 0
      false -> usage
    end
  end
end
