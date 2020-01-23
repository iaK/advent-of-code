defmodule AdventOfCode.Day3.Point do
  defstruct x: 0, y: 0, step: 0

  def x(%_{x: x}), do: x
  def y(%_{y: y}), do: y
  def step(%_{step: step}), do: step
end

defmodule AdventOfCode.Day3.Line do
  alias AdventOfCode.Day3.Point

  defstruct start: %Point{}, end: %Point{}, orientation: nil

  def create(start_point, end_point) do
      %__MODULE__{start: start_point, end: end_point, orientation: orientation(start_point, end_point)}
  end

  def can_cross(%_{orientation: :vertical} = _, %_{orientation: :vertical} = _), do: false
  def can_cross(%_{orientation: :horizontal} = _, %_{orientation: :horizontal} = _), do: false
  def can_cross(%_{orientation: :vertical} = start, %_{orientation: :horizontal} = ending), do: can_cross(ending, start)
  def can_cross(horizontal, vertical) do
    is_between(
          start_x(vertical),
          min(start_x(horizontal), end_x(horizontal)),
          max(start_x(horizontal), end_x(horizontal))
      ) &&
        is_between(
          start_y(horizontal),
          min(start_y(vertical), end_y(vertical)),
          max(start_y(vertical), end_y(vertical))
      )
  end

  def step(%_{start: %Point{step: step}}),do: step

  def start_x(%_{start: %Point{x: x}}),do: x
  def end_x(%_{end: %Point{x: x}}),do: x

  def start_y(%_{start: %Point{y: y}}),do: y
  def end_y(%_{end: %Point{y: y}}),do: y

  def ending(%_{end: ending}),do: ending
  def start(%_{start: start}),do: start

  def is_between(num, small, big) do
    num > small && num < big
  end

  def orientation(first_point, second_point) do
    case Point.x(first_point) == Point.x(second_point) do
      true -> :vertical
      false -> :horizontal
    end
  end

  def cross_point(vertical, %_{orientation: :horizontal} = horizontal), do: cross_point(horizontal, vertical)
  def cross_point(horizontal, vertical) do
    %Point{x: start_x(vertical), y: start_y(horizontal), step: sum_steps(horizontal, vertical)}
  end

  def sum_steps(horizontal, vertical) do
    step(horizontal) + step(vertical) +
      abs(start_x(horizontal) - start_x(vertical)) +
      abs(start_y(vertical) - start_y(horizontal))
  end
end

defmodule AdventOfCode.Day3.CrossedWires do
  alias AdventOfCode.Day3.Point
  alias AdventOfCode.Day3.Line

  def closest_cross_point(input) do
    input
      |> parse_input
      |> Enum.map(&(calculate_coordinates/1))
      |> Enum.map(&(points_to_lines/1))
      |> find_cross_point
      |> calculate_manhattan_distance
      |> Enum.sort
      |> Enum.at(0)
  end

  def cross_point_with_least_steps(input) do
    input
      |> parse_input
      |> Enum.map(&(calculate_coordinates/1))
      |> Enum.map(&(points_to_lines/1))
      |> find_cross_point
      |> Enum.map(&(Point.step(&1)))
      |> Enum.sort
      |> Enum.at(0)
    end

  def parse_input(input) do
    input
      |> String.trim
      |> String.split("\r\n")
      |> Enum.map(&(String.split(&1, ",")))
  end

  def calculate_coordinates(commands) do
    commands
      |> Enum.reduce([%Point{x: 0, y: 0, step: 0}], fn (command, [last_point | carry]) ->
        [calculate_coordinate(command_to_point(command, Point.step(last_point)), last_point) | [last_point | carry]]
      end)
      |> Enum.reverse
  end
  def calculate_coordinate(point, last_point) do
    %Point{
      x: Point.x(last_point) + Point.x(point),
      y: Point.y(last_point) + Point.y(point),
      step: Point.step(point)
    }
  end

  def command_to_point("U" <> number, step) do %Point{x: 0, y: elem(Integer.parse(number), 0), step: step + elem(Integer.parse(number), 0)} end
  def command_to_point("R" <> number, step) do %Point{x: elem(Integer.parse(number), 0), y: 0, step: step + elem(Integer.parse(number), 0)} end
  def command_to_point("D" <> number, step) do %Point{x: 0, y: -elem(Integer.parse(number), 0), step: step + elem(Integer.parse(number), 0)} end
  def command_to_point("L" <> number, step) do %Point{x: -elem(Integer.parse(number), 0), y: 0, step: step + elem(Integer.parse(number), 0)} end

  def points_to_lines([head | line]) do
    [_ | carry] = line
    |> Enum.reduce([head], fn (point, carry) -> points_to_line(point, carry) end)
    |> Enum.reverse

    carry
  end

  def points_to_line(point, [prev_point | []]) do
    [Line.create(prev_point, point), Line.create(prev_point, prev_point)]
  end
  def points_to_line(point, [prev_line | carry]) do
    [Line.create(Line.ending(prev_line), point), prev_line | carry]
  end

  def find_cross_point([first_wire, second_wire]) do
    first_wire
      |> Enum.map(&(find_cross_point(&1, second_wire)))
      |> Enum.reject(&(&1 == []))
      |> List.flatten
  end
  def find_cross_point(line, wire) do
    wire
      |> Enum.filter(&(Line.can_cross(&1, line)))
      |> Enum.map(&(Line.cross_point(&1, line)))
  end

  def calculate_manhattan_distance(points) do
    points
      |> Enum.map(&(abs(Point.x(&1)) + abs(Point.y(&1))))
  end
end
