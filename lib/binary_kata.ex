defmodule BinaryKata do

  @bom << 0xEF, 0xBB, 0xBF >>

  @doc """
  Should return `true` when given parameter start with UTF8 Byte-Order-Mark, otherwise `false`.
  @see https://en.wikipedia.org/wiki/Byte_order_mark
  """
  def has_utf8_bom?(@bom <> << _ :: binary >>), do: true
  def has_utf8_bom?(_), do: false


  @doc """
  Remove a UTF8 BOM if exists.
  """
  def remove_utf8_bom(@bom <> << rest :: binary >>), do: rest
  def remove_utf8_bom(rest), do: rest

  @doc """
  Add a UTF8 BOM if not exists.
  """
  def add_utf8_bom(@bom <> << rest :: binary >>), do: @bom <> rest
  def add_utf8_bom(rest), do: @bom <> rest

  @doc """
  Detecting types of images by their first bytes / magic numbers.

  @see https://en.wikipedia.org/wiki/JPEG
  @see https://en.wikipedia.org/wiki/Portable_Network_Graphics
  @see https://en.wikipedia.org/wiki/GIF
  """

  @jfif_header << 0xFF, 0xD8 >>
  @png_header << 0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A >>
  @gif_header "GIF89a"

  def image_type!( @jfif_header <> << rest :: binary >> ), do: :jfif
  def image_type!( @png_header  <> << rest :: binary >> ), do: :png
  def image_type!( @gif_header  <> << rest :: binary >> ), do: :gif
  def image_type!( _ ), do: :unknown

  @doc """
  Get the width and height from a GIF image.
  First 6 bytes contain the magic header.

  `width` will be little-endian in byte 7 and 8.
  `height` will be little-endian in byte 9 and 10.
  """
  def gif_dimensions!( @gif_header <> << w :: little-size(16) >> <> << h :: little-size(16) >> <> << _ :: binary >> ),
    do: { w, h }
  def gif_dimensions!( _ ), do: :error

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
