defmodule Day3.PasswordTest do
  use ExUnit.Case
  alias AdventOfCode.Day4.Password

  test "it can normalize a value" do
    assert Password.normalize(342190) == 344499
  end

  test "it can increment a value to the next valid format" do
    assert Password.increment(192568) == 199999
    assert Password.increment(123459) == 123466
  end

  test "it can detemine if a combination is valid" do
    assert Password.is_valid_combination?(123456) == false
    assert Password.is_valid_combination?(101010) == false
    assert Password.is_valid_combination?(122456) == true
    assert Password.is_valid_combination?(122262) == true
    assert Password.is_valid_combination?(111111) == true
  end

  test "it can detemine if a combination is valid group sensitive" do
    assert Password.is_valid_combination_group_sensitive?(221444) == true
    assert Password.is_valid_combination_group_sensitive?(123456) == false
    assert Password.is_valid_combination_group_sensitive?(101010) == false
    assert Password.is_valid_combination_group_sensitive?(122456) == true
    assert Password.is_valid_combination_group_sensitive?(122262) == false
    assert Password.is_valid_combination_group_sensitive?(111111) == false
  end

  test "it can count all possible combinations" do
    assert Password.all_possible_combinations(100000, 111111) == 0
    assert Password.all_possible_combinations(100000, 234000) == 1645
    assert Password.all_possible_combinations(387638, 919123) == 466
  end

  test "it can count all group sensitive combinations" do
    assert Password.count_combinations_group_insensitive(387638, 919123) == 292
  end
end
