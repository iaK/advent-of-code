defmodule AdventOfCode.Day3.Part1 do
  def cross_point(input) do
    input
      |> parse_input
      |> Enum.map(&(calculate_positions/1))
      |> find_cross_point
      |> calculate_manhattan_distance
      |> Enum.sort
      |> Enum.at(1)
  end

  def parse_input(input) do
    input
      |> String.trim
      |> String.split("\r\n")
      |> Enum.map(&(String.split(&1, ",")))
  end

  def calculate_positions(commands) do
    commands
      |> Enum.reduce([[0,0]], fn (command, carry) ->
        calculate_position(command, carry)
      end)
      |> Enum.reverse
  end

  def calculate_position(command, carry) do
    command = parse_command(command)
    last = Enum.at(carry,0)
    [[Enum.at(last,0) + Enum.at(command,0), Enum.at(last, 1) + Enum.at(command, 1)] | carry]
  end

  def parse_command(command) do
    case String.at(command, 0) do
      "U" ->  [0,digits(command)]
      "D" ->  [0,-digits(command)]
      "R" ->  [digits(command), 0]
      "L" ->  [-digits(command),0]
    end
  end

  def digits(string) do
    Regex.run(~r|[\d]+|, string) |> Enum.at(0) |> String.to_integer
  end

  def find_cross_point([first_wire, second_wire]) do
    # Cross point can be between two points.
    first_wire
      |> Enum.reduce_while(Enum.at(first_wire, 0), fn (first_point, second_point) -> is_between_points?(first_point,second_point, second_wire) end)
      # |> Enum.filter(&(is_between_points?(&1, second)))
    # coordinates
    #   |> IO.inspect(charlists: :as_lists)
    #   |> Enum.at(1)
    #   |> Enum.filter(&(Enum.member?(Enum.at(coordinates, 0), &1)))
  end

  def is_between_points?(first_point, second_point, points) do
    hit = points
      |> Enum.reduce_while(Enum.at(points, 0), fn (first_compare_point, second_compare_point) -> is_between_point?(first_point, second_point, first_compare_point, second_compare_point) end)
    IO.inspect(hit)
    case hit do
      {:halt, _} -> true
      _ -> false
    end
  end
  # 0,-2 | 0 2   2,1 | -2, 1
  # 0,-2|  0,2   2,1 | 4, 1
  def is_between_point?([x1, y1],[x2,y2], [cx1, cy1], [cx2, cy2]) do
      cond do
        x1 == x2 -> [x1, y]

      end
      case (px > x && px < lx) && (py > y && py < ly) do
        true -> {:halt, [x,y]}
        false -> {:cont, [px,py]}
      end
  end

  def calculate_manhattan_distance(points) do
    points
      |> Enum.map(&(Enum.at(&1, 0) + Enum.at(&1, 1)))
  end
end
