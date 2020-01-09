defmodule Day1.Part2Test do
  use ExUnit.Case
  alias AdventOfCode.Day1.Part2

  test "it includes the fuel weight in the calculation" do
    assert Part2.fuel_requirement("14") == 2
    assert Part2.fuel_requirement("1969") == 966
  end

  test "it accepts a list of modules" do
    assert Part2.fuel_requirement("12\r\n100756\r\n") == 50348
  end
end
