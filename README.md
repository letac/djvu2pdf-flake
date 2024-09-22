# Djvu2pdf-flake
([letac/djvu2pdf](https://github.com/letac/djvu2pdf) is fork of [vindvaki/djvu2pdf](https://github.com/vindvaki/djvu2pdf) one, not the `nixpkgs` one)

Using [nix package manager](https://nixos.org/) to enable reproducible builds.

It has hOCR (for keeping the text searchable).


# Usage
```
cd djvu2pdf-flake
nix develop
djvu2pdf yours.djvu new.pdf
exit
```

# Tried on

- NixOS 24.05, x86_64
- macOS 12.7.6, x86_64
 
