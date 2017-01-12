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
  # def remove_utf8_bom(_), do: raise "TODO: Implement me!"
  def remove_utf8_bom(file) do
    # file unless BinaryKata.has_utf8_bom? file
    case has_utf8_bom? file do
      true ->  priv_remove_bom(file)
      false -> file
    end
  end

  def priv_remove_bom(file) do
    <<0xEF, 0xBB, 0xBF, chunks :: binary>> = file
    chunks
  end

  @doc """
  Add a UTF8 BOM if not exists.
  """
  def add_utf8_bom(_), do: raise "TODO: Implement me!"

  @doc """
  Detecting types of images by their first bytes / magic numbers.

  @see https://en.wikipedia.org/wiki/JPEG
  @see https://en.wikipedia.org/wiki/Portable_Network_Graphics
  @see https://en.wikipedia.org/wiki/GIF
  """
  def image_type!(_), do: raise "TODO: Implement me!"

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
