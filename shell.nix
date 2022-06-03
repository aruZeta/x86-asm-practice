{ pkgs ? import <nixpkgs> {}
, ...
}:
pkgs.mkShell {
  buildInputs = with pkgs; [
    nasm
    gcc
    gdb
  ];

  shellHook = ''
  comp-asm () {
    file=$1
    file="''${file%.*}"
    nasm -f elf32 -g -F dwarf "$file.asm" \
      && ld -m elf_i386 "$file.o" -o "$file" \
      && echo "$file assembled and linked succesfully!"
  }
  '';
}
