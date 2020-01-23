defmodule Day3.CrossedWiresTest do
  use ExUnit.Case
  alias AdventOfCode.Day3.CrossedWires
  alias AdventOfCode.Day3.Point
  alias AdventOfCode.Day3.Line

  test "it can parse its input" do
    assert CrossedWires.parse_input("R10,D12,L13,U14\r\nR1,D2,L3,U4") == [["R10", "D12", "L13", "U14"], ["R1", "D2","L3", "U4"]];
  end

  test "it can convert the commands to coorinates" do
    assert CrossedWires.calculate_coordinates(["R10", "D12", "L13", "U14"]) == [
      %Point{x: 0, y: 0, step: 0},
      %Point{x: 10, y: 0, step: 10},
      %Point{x: 10, y: -12, step: 22},
      %Point{x: -3, y: -12, step: 35},
      %Point{x: -3, y: 2, step: 49}
    ]
  end

  test "it can calculate manhattan distances" do
    assert CrossedWires.calculate_manhattan_distance([%Point{x: 1,y: 2}, %Point{x: 2,y: 2}, %Point{x: 4,y: 1}]) == [3,4,5]
  end

  test "it can detect if two lines can cross" do
    assert Line.can_cross(
        %Line{start: %Point{x: -1, y: 0}, end: %Point{x: 1, y: 0}},
        %Line{start: %Point{x: 0, y: 1}, end: %Point{x: 0, y: -1}}
      ) == true
    assert Line.can_cross(
        %Line{start: %Point{x: 1, y: 0}, end: %Point{x: -1, y: 0}},
        %Line{start: %Point{x: 0, y: 1}, end: %Point{x: 0, y: -1}}
      ) == true
    assert Line.can_cross(
        %Line{start: %Point{x: -1, y: 0}, end: %Point{x: 1, y: 0}},
        %Line{start: %Point{x: 0, y: 1}, end: %Point{x: 0, y: 3}}
      ) == false
  end


  test "it can convert points to lines" do
    assert CrossedWires.points_to_lines([
      %Point{x: 0, y: 1},
      %Point{x: 0, y: 4},
      %Point{x: 2, y: 4},
      %Point{x: 2, y: 8}
    ]) == [
      %Line{start: %Point{x: 0, y: 1}, end: %Point{x: 0, y: 4}, orientation: :vertical},
      %Line{start: %Point{x: 0, y: 4}, end: %Point{x: 2, y: 4}, orientation: :horizontal},
      %Line{start: %Point{x: 2, y: 4}, end: %Point{x: 2, y: 8}, orientation: :vertical}
    ]
  end

  test "it can detect crosses" do
    assert CrossedWires.find_cross_point(
      Line.create(%Point{x: 0, y: -1}, %Point{x: 0, y: 1}),
      [Line.create(%Point{x: -1, y: 0}, %Point{x: 1, y: 0})]
    ) == [%Point{step: 2, x: 0, y: 0}]
  end

  test "it can calculate manhattan distances from commands" do
    assert CrossedWires.closest_cross_point("R75,D30,R83,U83,L12,D49,R71,U7,L72\r\nU62,R66,U55,R34,D71,R55,D58,R83") == 159
    assert CrossedWires.closest_cross_point("R98,U47,R26,D63,R33,U87,L62,D20,R33,U53,R51\r\nU98,R91,D20,R16,D67,R40,U7,R15,U6,R7") == 135
  end

  test "it can find the cross point with least steps" do
    assert CrossedWires.cross_point_with_least_steps("R75,D30,R83,U83,L12,D49,R71,U7,L72\r\nU62,R66,U55,R34,D71,R55,D58,R83") == 610
    assert CrossedWires.cross_point_with_least_steps("R98,U47,R26,D63,R33,U87,L62,D20,R33,U53,R51\r\nU98,R91,D20,R16,D67,R40,U7,R15,U6,R7") == 410
  end
end
