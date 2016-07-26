defmodule BinaryKata do
  @doc """
  Should return `true` when given parameter start with UTF8 Byte-Order-Mark, otherwise `false`.
  @see https://en.wikipedia.org/wiki/Byte_order_mark
  """
  def has_utf8_bom?(<< 0xEF, 0xBB, 0xBF, _ :: binary >>), do: true
  def has_utf8_bom?(_), do: false

  @doc """
  Remove a UTF8 BOM if exists.
  """
  def remove_utf8_bom(<< 0xEF, 0xBB, 0xBF, rest :: binary >>), do: rest
  def remove_utf8_bom(rest), do: rest

  @doc """
  Add a UTF8 BOM if not exists.
  """
  def add_utf8_bom(shorty), do: << 0xEF, 0xBB, 0xBF >> <> remove_utf8_bom(shorty)

  @doc """
  Detecting types of images by their first bytes / magic numbers.

  @see https://en.wikipedia.org/wiki/JPEG
  @see https://en.wikipedia.org/wiki/Portable_Network_Graphics
  @see https://en.wikipedia.org/wiki/GIF
  """
  def image_type!(<<0xff, 0xd8, 0xff, _ :: binary >>), do: :jfif
  def image_type!(<<0x89, 0x50, 0x4e, 0x47, 0x0d, 0x0a, 0x1a, 0x0a, _ :: binary >> ), do: :png
  def image_type!(<<"GIF87a", _ :: binary >>), do: :gif
  def image_type!(<<"GIF89a", _ :: binary >>), do: :gif
  def image_type!(_), do: :unknown

  @doc """
  Get the width and height from a GIF image.
  First 6 bytes contain the magic header.

  `width` will be little-endian in byte 7 and 8.
  `height` will be little-endian in byte 9 and 10.
  """
  def gif_dimensions!(<<"GIF89a", width::16-little, height::16-little, _::binary >>), do: {width, height}

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
