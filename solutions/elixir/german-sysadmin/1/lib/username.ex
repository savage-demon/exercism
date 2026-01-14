defmodule Username do
  def sanitize([]), do: ~c""

  def sanitize([head | tail]) when head in ?a..?z, do: [head | sanitize(tail)]

  def sanitize([head | tail]) when head == ?_, do: [head | sanitize(tail)]

  def sanitize([head | tail]) do
    c = case head do
      ?ä -> ~c"ae"
      ?ö -> ~c"oe"
      ?ü -> ~c"ue"
      ?ß -> ~c"ss"
      _ -> ~c""
    end

    c ++ sanitize(tail)
  end  
end
