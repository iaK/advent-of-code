defmodule Day1.FuelUsageCalculatorTest do
  use ExUnit.Case
  alias AdventOfCode.Day1.FuelUsageCalculator

  test "negative fuel values counts as 0" do
      assert FuelUsageCalculator.usage(2) == 0
      assert FuelUsageCalculator.usage(0) == 0
    end

    test "it can calculate fuel usage for one module" do
      assert FuelUsageCalculator.usage(14) == 2
    end
end
