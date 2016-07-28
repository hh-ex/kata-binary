defmodule BinaryKata do

  @doc """
  Should return `true` when given parameter start with UTF8 Byte-Order-Mark, otherwise `false`.
  @see https://en.wikipedia.org/wiki/Byte_order_mark
  """
  def has_utf8_bom?(<<0xEF, 0xBB, 0xBF, _ :: binary>>), do: true
  def has_utf8_bom?(_), do: false

  @doc """
  Remove a UTF8 BOM if exists.
  """
  def remove_utf8_bom(<<0xEF, 0xBB, 0xBF, rest :: binary>>), do: rest
  def remove_utf8_bom(rest), do: rest

  @doc """
  Add a UTF8 BOM if not exists.
  """
  def add_utf8_bom(rest), do: <<0xEF, 0xBB, 0xBF>> <> remove_utf8_bom(rest)

  @doc """
  Detecting types of images by their first bytes / magic numbers.

  @see https://en.wikipedia.org/wiki/JPEG
  @see https://en.wikipedia.org/wiki/Portable_Network_Graphics
  @see https://en.wikipedia.org/wiki/GIF
  """
  def image_type!(<<0xFF, 0xD8, 0xFF, _ :: binary>>), do: :jfif
  def image_type!(<<0x89, 0x50, 0x4e, 0x47, _ :: binary>>), do: :png
  def image_type!(<<0x47, 0x49, 0x46, 0x38, 0x39, 0x61, _ :: binary>>), do: :gif
  def image_type!(_), do: :unknown

  @doc """
  Get the width and height from a GIF image.
  First 6 bytes contain the magic header.

  `width` will be little-endian in byte 7 and 8.
  `height` will be little-endian in byte 9 and 10.
  """
  def gif_dimensions!(<<0x47, 0x49, 0x46, 0x38, 0x39, 0x61, width :: little-size(16), height :: little-size(16), _ :: binary>>), do: {width, height}
  def gif_dimensions!(_), do: :error

  @doc """
  Parsing Payload of a ARP packet. Padding will be omitted.

  @see https://en.wikipedia.org/wiki/Address_Resolution_Protocol
  """
  def parse_arp_packet_ipv4!(<<
    _ :: size(48),
    operation :: size(16),
    sender_address :: size(48),
    sender_ip :: 4-binary,
    target_address :: size(48),
    target_ip :: 4-binary,
    _ :: binary
  >>) do
    {
      operation |> arp_operation_to_atom,
      sender_address,
      sender_ip |> ip_to_tuple,
      target_address,
      target_ip |> ip_to_tuple
    }
  end


  # Helper for `parse_arp_packet_ipv4!`
  defp ip_to_tuple(<< ip_1, ip_2, ip_3, ip_4 >>), do: {ip_1, ip_2, ip_3, ip_4}
  defp arp_operation_to_atom(1), do: :request
  defp arp_operation_to_atom(2), do: :response

end
