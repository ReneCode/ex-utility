defmodule FractionIndexTest do
  use ExUnit.Case

  # doctest FractionIndex

  test "new" do
    assert FractionIndex.new() == "U"
  end

  test "next" do
    assert FractionIndex.next("0") == "1"
    assert FractionIndex.next("9") == "A"
    assert FractionIndex.next("A") == "B"
    assert FractionIndex.next("Z") == "a"
    assert FractionIndex.next("a") == "b"
    assert FractionIndex.next("r") == "s"
    assert FractionIndex.next("z") == "z0"

    assert FractionIndex.next("41") == "42"
    assert FractionIndex.next("444m") == "444n"
  end

  test "prev" do
    assert FractionIndex.prev("9") == "8"
    assert FractionIndex.prev("A") == "9"
    assert FractionIndex.prev("a") == "Z"
    assert FractionIndex.prev("1") == "0z"
    assert_raise RuntimeError, fn -> FractionIndex.prev("0") end
    assert_raise RuntimeError, fn -> FractionIndex.prev("20") end
    assert FractionIndex.prev("05") == "04"
    assert FractionIndex.prev("49") == "48"
  end

  test "between" do
    assert FractionIndex.between("2", "8") == "5"
    assert FractionIndex.between("2", "4") == "3"
    assert FractionIndex.between("2", "5") == "3"
    assert FractionIndex.between("2", "6") == "4"
  end
end
