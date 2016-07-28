defmodule BinaryKata do

  @doc """
  Should return `true` when given parameter start with UTF8 Byte-Order-Mark, otherwise `false`.
  @see https://en.wikipedia.org/wiki/Byte_order_mark
  """
  def has_utf8_bom?(<<0xef,0xbb,0xbf,_ :: binary>>), do: true
  def has_utf8_bom?(_), do: false

  @doc """
  Remove a UTF8 BOM if exists.
  """
  def remove_utf8_bom(<<0xef,0xbb,0xbf,rest :: binary>>), do: rest
  def remove_utf8_bom(data) when is_binary(data), do: data

  @doc """
  Add a UTF8 BOM if not exists.
  """
  def add_utf8_bom(<<0xef,0xbb,0xbf,rest :: binary>> = data), do: data
  def add_utf8_bom(data), do: <<0xef,0xbb,0xbf,data :: binary>>

  @doc """
  Detecting types of images by their first bytes / magic numbers.

  @see https://en.wikipedia.org/wiki/JPEG
  @see https://en.wikipedia.org/wiki/Portable_Network_Graphics
  @see https://en.wikipedia.org/wiki/GIF
  """
  def image_type!(<<"GIF87a",_ :: binary>>), do: :gif
  def image_type!(<<"GIF89a", _ :: binary>>), do: :gif
  def image_type!(<<0x89,0x50,0x4e,0x47,0x0d,0x0a,0x1a,0x0a, _ :: binary>>), do: :png
  def image_type!(<<0xff,0xd8, _ :: binary>>), do: :jfif
  def image_type!(<<0xff,0xd9, _ :: binary>>), do: :jfif
  def image_type!(_), do: :unknown

  @doc """
  Get the width and height from a GIF image.
  First 6 bytes contain the magic header.

  `width` will be little-endian in byte 7 and 8.
  `height` will be little-endian in byte 9 and 10.
  """
  def gif_dimensions!(<<header :: binary-size(6),_ :: binary>>) when header != <<"GIF87a">> and header != <<"GIF89a">>, do: :error
  def gif_dimensions!(<<_ :: binary-size(6), width :: little-integer-size(16), height :: little-integer-size(16), _ :: binary>>), do: {width, height}

  @doc """
  Parsing Payload of a ARP packet. Padding will be omitted.

  Internet Protocol (IPv4) over Ethernet ARP packet
  octet offset 	0 	1
  0 	Hardware type (HTYPE)
  2 	Protocol type (PTYPE)
  4 	Hardware address length (HLEN) | Protocol address length (PLEN)
  6 	Operation (OPER)
  8 	Sender hardware address (SHA) (first 2 bytes)
  10 	(next 2 bytes)
  12 	(last 2 bytes)
  14 	Sender protocol address (SPA) (first 2 bytes)
  16 	(last 2 bytes)
  18 	Target hardware address (THA) (first 2 bytes)
  20 	(next 2 bytes)
  22 	(last 2 bytes)
  24 	Target protocol address (TPA) (first 2 bytes)
  26 	(last 2 bytes)

  @see https://en.wikipedia.org/wiki/Address_Resolution_Protocol
  """
  def parse_arp_packet_ipv4!(<<_ :: binary-size(6), operation :: binary-size(2), sender_address :: integer-size(48), sender_ip :: binary-size(4), target_adress :: integer-size(48), target_ip :: binary-size(4), _ :: binary>>) do
    operation = case operation do
      <<0,1>> -> :request
      <<0,2>> -> :response
    end

    <<a,b,c,d>> = sender_ip
    <<e,f,g,h>> = target_ip

    {operation, sender_address, {a,b,c,d}, target_adress, {e,f,g,h}}
  end

  # Helper for `parse_arp_packet_ipv4!`
  defp arp_operation_to_atom(1), do: :request
  defp arp_operation_to_atom(2), do: :response

end
