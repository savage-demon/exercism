defmodule WineCellar do
  @spec explain_colors() :: [{:red, <<_::432>>} | {:rose, <<_::592>>} | {:white, <<_::248>>}, ...]
  def explain_colors do
    [
      white: "Fermented without skin contact.",
      red: "Fermented with skin contact using dark-colored grapes.",
      rose: "Fermented with some skin contact, but not enough to qualify as a red wine."
    ]
  end

  @spec filter(keyword(), atom()) :: any()
  def filter(cellar, color, opts \\ []) do
    wines = Keyword.get_values(cellar, color)

    # Идем по списку опций, уменьшая список вин
    Enum.reduce(opts, wines, &apply_filter/2)
  end

  # 1. Фильтр по году
  defp apply_filter({:year, year}, wines) do
    Enum.filter(wines, fn {_, y, _} -> y == year end)
  end

  # 2. Фильтр по стране
  defp apply_filter({:country, country}, wines) do
    Enum.filter(wines, fn {_, _, c} -> c == country end)
  end

  # 3. Заглушка (чтобы не упасть, если придет левый ключ)
  defp apply_filter(_, wines), do: wines
end
