defmodule Day3.Part1Test do
  use ExUnit.Case
  alias AdventOfCode.Day3.Part1

  test "it can parse its input" do
    assert Part1.parse_input("R10,D12,L13,U14\r\nR1,D2,L3,U4") == [["R10", "D12", "L13", "U14"], ["R1", "D2","L3", "U4"]];
  end

  test "it can convert the commands to coorinates" do
    assert Part1.calculate_positions(["R10", "D12", "L13", "U14"]) == [[0, 0], [10, 0], [10, -12], [-3, -12], [-3, 2]]
  end

  test "it can find all places two lines cross" do
    assert Part1.find_cross_point([ [[0,1], [3,1]], [[1,0], [1,3]] ]) == [[1,1]]
  end

  test "it can calculate manhattan distances" do
    assert Part1.calculate_manhattan_distance([[1,2], [2,2], [4,1]]) == [3,4,5]
  end

  test "it can calculate manhattan distances from commands" do
    assert Part1.cross_point("R75,D30,R83,U83,L12,D49,R71,U7,L72\r\nU62,R66,U55,R34,D71,R55,D58,R83") == 159
  end
end
