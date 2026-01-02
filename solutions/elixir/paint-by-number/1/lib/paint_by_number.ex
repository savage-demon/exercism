defmodule PaintByNumber do
  def palette_bit_size(color_count) do
    count_bits(color_count, 1)
  end

  defp count_bits(color_count, power) do
    if 2 ** power >= color_count do
      power
    else 
      count_bits(color_count, power + 1)
    end
  end

  def empty_picture() do
    <<>>
  end

  def test_picture() do
    <<0::2, 1::2, 2::2, 3::2>>
  end

  def prepend_pixel(picture, color_count, pixel_color_index) do
    <<pixel_color_index::size(palette_bit_size(color_count)), picture::bitstring>>
  end

  def get_first_pixel(<<>>, _), do: nil

  def get_first_pixel(picture, color_count) do
    size = palette_bit_size(color_count)
    <<pixel::size(size), _rest::bits>> = picture
    pixel
  end

  def drop_first_pixel(<<>>, _), do: empty_picture()

  def drop_first_pixel(picture, color_count) do
    s = palette_bit_size(color_count)
    <<_x::size(s), rest::bits>> = picture
    rest
  end

  def concat_pictures(picture1, picture2) do
    <<picture1::bitstring, picture2::bitstring>>
  end
end
