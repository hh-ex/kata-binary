defmodule BinaryKataTest do
  use ExUnit.Case, async: false
  doctest BinaryKata

  test "has_utf8_bom?" do
    assert false == fixture_file("file_utf8.txt") |> BinaryKata.has_utf8_bom?
    assert true == fixture_file("file_utf8_bom.txt") |> BinaryKata.has_utf8_bom?
  end

  test "remove_utf8_bom" do
    assert false == fixture_file("file_utf8.txt") |> BinaryKata.remove_utf8_bom |> BinaryKata.has_utf8_bom?
    assert false == fixture_file("file_utf8_bom.txt") |> BinaryKata.remove_utf8_bom |> BinaryKata.has_utf8_bom?
  end

  test "add_utf8_bom" do
    assert true == fixture_file("file_utf8.txt") |> BinaryKata.add_utf8_bom |> BinaryKata.has_utf8_bom?
    assert true == fixture_file("file_utf8_bom.txt") |> BinaryKata.add_utf8_bom |> BinaryKata.has_utf8_bom?
  end

  test "image_type!" do
    assert :jfif == fixture_file("image.jpg") |> BinaryKata.image_type!
    assert :png == fixture_file("image.png") |>  BinaryKata.image_type!
    assert :gif == fixture_file("image.gif") |> BinaryKata.image_type!
    assert :unknown == "something else" |> BinaryKata.image_type!
  end

  test "gif_dimensions!" do
    assert {480, 360} == fixture_file("image.gif") |> BinaryKata.gif_dimensions!
    assert :error == "something else" |> BinaryKata.gif_dimensions!
  end

  test "parse_arp_packet_ipv4! gratious" do
    assert {:request, 22866946603262, {192, 168, 1, 4}, 281474976710655, {192, 168, 1, 4}}
      == "000108000604000114cc203ab8fec0a80104ffffffffffffc0a80104000000000000000000000000000000000000"
        |> Base.decode16!(case: :lower)
        |> BinaryKata.parse_arp_packet_ipv4!
  end
  test "parse_arp_packet_ipv4! who has" do
    assert {:request, 73853929453, {192, 168, 1, 6}, 0, {192, 168, 1, 110}}
      == "00010800060400010011320987edc0a80106000000000000c0a8016e000000000000000000000000000000000000"
        |> Base.decode16!(case: :lower)
        |> BinaryKata.parse_arp_packet_ipv4!
  end
  test "parse_arp_packet_ipv4! is at" do
    assert {:response, 66619481563281, {192, 168, 1, 110}, 73853929453, {192, 168, 1, 6}}
      == "00010800060400023c970e88a091c0a8016e0011320987edc0a80106"
        |> Base.decode16!(case: :lower)
        |> BinaryKata.parse_arp_packet_ipv4!
  end

  defp fixture_file(filename) do
    "fixtures/" <> filename
      |> Path.expand(__DIR__)
      |> File.read!
  end
end
