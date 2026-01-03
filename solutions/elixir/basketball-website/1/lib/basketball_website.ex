defmodule BasketballWebsite do
  def extract_from_path(data, path) do
    case String.split(path, ".", parts: 2) do
      [key, rest_path] ->
        extract_from_path(data[key], rest_path)
      [last_key] ->
        data[last_key]
    end
  end

  def get_in_path(data, path) do
    get_in(data, String.split(path, "."))
  end
end
