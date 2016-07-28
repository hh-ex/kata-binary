defmodule BinaryKata do

  @doc """
  Should return `true` when given parameter start with UTF8 Byte-Order-Mark, otherwise `false`.
  @see https://en.wikipedia.org/wiki/Byte_order_mark
  """
  def has_utf8_bom?(<< 0xEF, 0xBB, 0xBF, _rest::binary >>), do: true
  def has_utf8_bom?(<< _nope::binary >>), do: false

  @doc """
  Remove a UTF8 BOM if exists.
  """
  def remove_utf8_bom(<< 0xEF, 0xBB, 0xBF, rest::binary >>), do: rest
  def remove_utf8_bom(<< all::binary >>), do: all

  @doc """
  Add a UTF8 BOM if not exists.
  """
  def add_utf8_bom(<< 0xEF, 0xBB, 0xBF, rest::binary >>), do: << 0xEF, 0xBB, 0xBF >> <> rest
  def add_utf8_bom(<< all::binary >>), do: << 0xEF, 0xBB, 0xBF >> <> all

  @doc """
  Detecting types of images by their first bytes / magic numbers.

  @see https://en.wikipedia.org/wiki/JPEG
  @see https://en.wikipedia.org/wiki/Portable_Network_Graphics
  @see https://en.wikipedia.org/wiki/GIF
  """
  def image_type!(<< 0xFF, 0xD8, 0xFF, _rest::binary >>), do: :jpeg
  def image_type!(<< 0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A, _rest::binary >>), do: :png
  def image_type!(<< 0x47, 0x49, 0x46, 0x38, _rest::binary >>), do: :gif
  def image_type!(_), do: :unknown

  @doc """
  Get the width and height from a GIF image.
  First 6 bytes contain the magic header.

  `width` will be little-endian in byte 7 and 8.
  `height` will be little-endian in byte 9 and 10.
  """
  def gif_dimensions!(<< 0x47, 0x49, 0x46, 0x38, _, _, width::little-integer-size(16), height::little-integer-size(16), _rest::binary >>), do: {width, height}
  def gif_dimensions!(_), do: :error

  @doc """
  Parsing Payload of a ARP packet. Padding will be omitted.

  @see https://en.wikipedia.org/wiki/Address_Resolution_Protocol
  """
  def parse_arp_packet_ipv4!(<<_head::48,
                              1::16,
                              sender_mac::integer-size(48),
                              sender_ip_1::integer-size(8),
                              sender_ip_2::integer-size(8),
                              sender_ip_3::integer-size(8),
                              sender_ip_4::integer-size(8),
                              target_mac::integer-size(48),
                              target_ip_1::integer-size(8),
                              target_ip_2::integer-size(8),
                              target_ip_3::integer-size(8),
                              target_ip_4::integer-size(8),
                              _rest::binary >>) do
      {:request, sender_mac, {sender_ip_1, sender_ip_2, sender_ip_3, sender_ip_4}, target_mac, {target_ip_1, target_ip_2, target_ip_3, target_ip_4}}
  end

  def parse_arp_packet_ipv4!(<<_head::48,
                              2::16,
                              sender_mac::integer-size(48),
                              sender_ip_1::integer-size(8),
                              sender_ip_2::integer-size(8),
                              sender_ip_3::integer-size(8),
                              sender_ip_4::integer-size(8),
                              target_mac::integer-size(48),
                              target_ip_1::integer-size(8),
                              target_ip_2::integer-size(8),
                              target_ip_3::integer-size(8),
                              target_ip_4::integer-size(8),
                              _rest::binary >>) do
      {:response, sender_mac, {sender_ip_1, sender_ip_2, sender_ip_3, sender_ip_4}, target_mac, {target_ip_1, target_ip_2, target_ip_3, target_ip_4}}
  end

end
