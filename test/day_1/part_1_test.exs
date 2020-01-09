defmodule Day1.Part1Test do
  use ExUnit.Case
  alias AdventOfCode.Day1.Part1

  test "it can calculate the fuel usage of a module" do
    assert Part1.fuel_requirement("12") == 2
  end

  test "it accepts a list of modules" do
    assert Part1.fuel_requirement("12\r\n14\r\n1969\r\n") == 658
  end

  test "it works with sample data" do
    assert Part1.fuel_requirement(AdventOfCode.FileReader.get_input("lib/day_1/input.txt")) == 3457281
  end
end
