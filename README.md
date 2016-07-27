# BinaryKata

Kata for the Hamburg-Elixir Usergroup by Julius Beckmann (@h4cc).

## Contents

This kata contains tasks for a few simple binary pattern matching functions like:

* Has a content a UTF-8 BOM?
* Remove a UTF-8 BOM from content.
* Add a UTF-8 BOM to content.
* Detect JPG/PNG/GIF images.
* Read width and height from a GIF image.
* Parsing a ARP packet.

Have fun!

## Hints

* Have a look out for binary values and magic constants.
* Also check for endianess which can be little or big.
* Make sure you use byte and bits correctly.
* Use `IO.inspect` to "see" the stuff you are working with.
* Use the `iex -S mix` shell to try stuff out.

Get yourself a HEX Editor to "see" the binary stuff in a file.

* Ubuntu: https://wiki.ubuntuusers.de/GHex/
* Mac: http://ridiculousfish.com/hexfiend/

## Resources

Elixir getting started with binaries: http://elixir-lang.org/getting-started/binaries-strings-and-char-lists.html

Resource for learning binary pattern matching:  http://www.zohaib.me/binary-pattern-matching-in-elixir/

