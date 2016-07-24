defmodule BinaryKata do

  @doc """
  Should return `true` when given parameter start with UTF8 Byte-Order-Mark, otherwise `false`.
  @see https://de.wikipedia.org/wiki/Byte_Order_Mark
  """
  def has_utf8_bom?(<<239, 187, 191, _::binary>>), do: true
  def has_utf8_bom?(_), do: false

  @doc """
  Remove a UTF8 BOM if exists.
  """
  def remove_utf8_bom(<<239, 187, 191, content::binary>>), do: content
  def remove_utf8_bom(content), do: content

  @doc """
  Add a UTF8 BOM if not exists.
  """
  def add_utf8_bom(content), do: <<239, 187, 191>> <> remove_utf8_bom(content)

  @doc """
  Detecting types of images by their first bytes / magic numbers.

  @see https://de.wikipedia.org/wiki/JPEG_File_Interchange_Format
  @see https://en.wikipedia.org/wiki/Portable_Network_Graphics
  @see https://en.wikipedia.org/wiki/GIF
  """
  def image_type!(<<0xFF, 0xD8, _::binary>>), do: :jfif
  def image_type!(<<0x89, 0x50, 0x4E, 0x47, _::binary>>), do: :png
  def image_type!(<<0x47, 0x49, 0x46, 0x38, 0x39, 0x61, _::binary>>), do: :gif
  def image_type!(_), do: :unknown

  @doc """
  Get the width and height from a GIF image.
  First 6 bytes contain the magic header.

  `width` will be little-endian in byte 7 and 8.
  `height` will be little-endian in byte 9 and 10.
  """
  def gif_dimensions!(<<0x47, 0x49, 0x46, 0x38, 0x39, 0x61, width::little-size(16), height::little-size(16), _::binary>>), do: {width, height}
  def gif_dimensions!(_), do: :error

  @doc """
  Parsing Payload of a ARP packet. Padding will be omitted.

  @see https://de.wikipedia.org/wiki/Address_Resolution_Protocol
  """
  def parse_arp_packet_ipv4!(<<
    # Defined values for IPv4
    1::size(16),
    2048::size(16),
    6::size(8),
    4::size(8),
    # Payload
    operation::size(16),
    src_mac_addr::size(48),
    src_ip_addr_1, src_ip_addr_2, src_ip_addr_3, src_ip_addr_4,
    target_mac_addr::size(48),
    target_ip_addr_1, target_ip_addr_2, target_ip_addr_3, target_ip_addr_4,
    _padding::binary>>) do
    {
      operation |> arp_operation_to_atom,
      src_mac_addr,
      {src_ip_addr_1, src_ip_addr_2, src_ip_addr_3, src_ip_addr_4},
      target_mac_addr,
      {target_ip_addr_1, target_ip_addr_2, target_ip_addr_3, target_ip_addr_4}
    }
  end

  # Helper for `parse_arp_packet_ipv4!`
  defp arp_operation_to_atom(1), do: :request
  defp arp_operation_to_atom(2), do: :response

end
