defmodule JustOneMore do

  def level1(list) do
    Enum.map(list, &incr/1)
  end

  def level2(list) do
    list
    |> Enum.reduce([], &to_integer_only/2)
    |> Enum.reverse
    |> Enum.map(&incr/1)
  end

  def level3(list) do
    list
    |> Enum.map(&tokenize/1)
    |> Enum.map(&incr_integers/1)
    |> Enum.map(&(Enum.join(&1)))
  end

  # helpers

  defp incr(i), do: i+1

  defp to_integer_only(element, integer_list) do
    case Integer.parse(element) do
      {int, ""} -> [int|integer_list]
      {_int, _} -> integer_list # number, but not an integer
      :error -> integer_list
    end
  end

  defp tokenize(str) do
    Regex.split(~r{()\d+()}, str, on: [1,2])
  end

  defp incr_integers(tokens) do
    Enum.map(tokens, fn token ->
      case Integer.parse(token) do
        {int, ""} -> incr(int)
        {_int, _} -> token
        :error -> token
      end
    end
    )
  end
end

ExUnit.start
defmodule JustOneMoreTest do
  use ExUnit.Case, async: true

  test "Level 1 example" do
    assert JustOneMore.level1([1, 2, 3]) == [2, 3, 4]
  end

  test "Level 1 description example" do
    assert(
      JustOneMore.level1([1, 0, -1, 5, 100, 37, 20, 18, 12, 0])
      == [2, 1, 0, 6, 101, 38, 21, 19, 13, 1]
    )
  end


  test "Level 2 example" do
    assert JustOneMore.level2(["1", "b", "3"]) == [2, 4]
  end

  test "Level 2 description example" do
    assert(
      JustOneMore.level2(~w(1 c 0 -1 5 b 100 37 a 20 18 12 0))
      == [2, 1, 0, 6, 101, 38, 21, 19, 13, 1]
    )
  end

  test "Level 3 example" do
    assert(
      JustOneMore.level3(["ab12", "a5", "b23a51"])
      == ["ab13", "a6", "b24a52"]
    )
  end

  test "Level 3 description example" do
    assert(
      JustOneMore.level3(~w(ab123 gh00 ijk8 lmn12 cd99ef11))
      == ~w(ab124 gh01 ijk9 lmn13 cd100ef12)
    )
  end
end
