defmodule FractionIndex do
  @type t :: String.t()

  @firstChar ?0
  @secondChar ?1
  @lastChar ?z

  # valid chars
  # 0..9,A..Z,a..z

  def new() do
    middle = div(@firstChar + @lastChar, 2)
    <<middle>>
  end

  @spec next(FractionIndex.t()) :: FractionIndex.t()
  def next(idx) do
    len = String.length(idx)
    start = binary_part(idx, 0, len - 1)
    <<h>> = binary_part(idx, len - 1, 1)

    case h do
      @lastChar -> start <> <<h>> <> <<@firstChar>>
      _ -> start <> <<next_nr(h)>>
    end
  end

  @spec prev(FractionIndex.t()) :: FractionIndex.t()
  def prev(idx) do
    len = String.length(idx)
    start = binary_part(idx, 0, len - 1)
    <<h>> = binary_part(idx, len - 1, 1)

    case h do
      @firstChar -> raise "no fraction index before: " <> idx
      @secondChar -> start <> <<@firstChar>> <> <<@lastChar>>
      _ -> start <> <<prev_nr(h)>>
    end
  end

  @spec between(FractionIndex.t(), FractionIndex.t()) :: FractionIndex.t()
  def between(a, b) do
    <<h1>> = String.last(a)
    <<h2>> = String.last(b)
    middle = div(h1 + h2, 2)
    <<middle>>
  end

  @spec next_nr(Integer) :: Integer
  defp next_nr(nr) do
    case nr do
      ?9 -> ?A
      ?Z -> ?a
      ?z -> raise "no nr after z"
      _ -> nr + 1
    end
  end

  @spec prev_nr(Integer) :: Integer
  defp prev_nr(nr) do
    case nr do
      ?0 -> raise "no nr before 0"
      ?A -> ?9
      ?a -> ?Z
      _ -> nr - 1
    end
  end
end
