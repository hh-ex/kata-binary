defmodule BinaryKata do

  @doc """
  Should return `true` when given parameter start with UTF8 Byte-Order-Mark, otherwise `false`.
  @see https://en.wikipedia.org/wiki/Byte_order_mark
  """
  def has_utf8_bom?(<< 0xef, 0xbb, 0xbf, _::bits >>), do: true
  def has_utf8_bom?(_), do: false

  @doc """
  Remove a UTF8 BOM if exists.
  """
  def remove_utf8_bom(<< 0xef, 0xbb, 0xbf, rest::bits >>), do: rest
  def remove_utf8_bom(str), do: str

  @doc """
  Add a UTF8 BOM if not exists.
  """
  def add_utf8_bom(str), do: << 0xef, 0xbb, 0xbf >> <> str

  @doc """
  Detecting types of images by their first bytes / magic numbers.

  @see https://en.wikipedia.org/wiki/JPEG
  @see https://en.wikipedia.org/wiki/Portable_Network_Graphics
  @see https://en.wikipedia.org/wiki/GIF
  """
  def image_type!(<< 0xff, 0xd8, 0xff, _::bits >>), do: :jfif
  def image_type!(<< 0x47, 0x49, 0x46, 0x38, 0x39, 0x61, _::bits >>), do: :gif
  def image_type!(<< 0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A, _::bits >>), do: :png
  def image_type!(_), do: :unknown

  @doc """
  Get the width and height from a GIF image.
  First 6 bytes contain the magic header.

  `width` will be little-endian in byte 7 and 8.
  `height` will be little-endian in byte 9 and 10.
  """
  def gif_dimensions!(_), do: raise "TODO: Implement me!"

  @doc """
  Parsing Payload of a ARP packet. Padding will be omitted.

  @see https://en.wikipedia.org/wiki/Address_Resolution_Protocol
  """
  def parse_arp_packet_ipv4!(_) do
      raise "TODO: Implement me!"
  end

  # Helper for `parse_arp_packet_ipv4!`
  defp arp_operation_to_atom(1), do: :request
  defp arp_operation_to_atom(2), do: :response

end
