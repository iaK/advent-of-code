defmodule AdventOfCode do
  alias AdventOfCode.FileReader

    @doc """
    ## Examples
        iex> AdventOfCode.day_1_part_1()
        3457281
  """
  def day_1_part_1 do
    AdventOfCode.Day1.Part1.fuel_requirement(FileReader.get_input("lib/day_1/input.txt"))
  end

  @doc """
    ## Examples
        iex> AdventOfCode.day_1_part_2()
        5183030
  """
  def day_1_part_2 do
    AdventOfCode.Day1.Part2.fuel_requirement(FileReader.get_input("lib/day_1/input.txt"))
  end

  @doc """
    ## Examples
        iex> AdventOfCode.day_2_part_1()
        6730673
  """
  def day_2_part_1 do
    AdventOfCode.Day2.Part1.intcode(FileReader.get_input("lib/day_2/input.txt"), [12, 2])
  end

   @doc """
    ## Examples
        iex> AdventOfCode.day_2_part_2()
        3749
  """
  def day_2_part_2 do
    AdventOfCode.Day2.Part2.intcode(FileReader.get_input("lib/day_2/input.txt"))
  end

  @doc """
    ## Examples
        iex> AdventOfCode.day_3_part_1()
        303
  """
  def day_3_part_1 do
    AdventOfCode.Day3.CrossedWires.closest_cross_point(FileReader.get_input("lib/day_3/input.txt"))
  end

  @doc """
    ## Examples
        iex> AdventOfCode.day_3_part_2()
        303
  """
  def day_3_part_2 do
    AdventOfCode.Day3.CrossedWires.cross_point_with_least_steps(FileReader.get_input("lib/day_3/input.txt"))
  end
end
