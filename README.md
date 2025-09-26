# Djvu2pdf-flake
([letac/djvu2pdf](https://github.com/letac/djvu2pdf) is fork of [vindvaki/djvu2pdf](https://github.com/vindvaki/djvu2pdf) one, not the `nixpkgs` one)

Using [nix package manager](https://nixos.org/) to enable reproducible builds.

It has hOCR (for keeping the text searchable).


# Usage
Use 
```
nix run github:letac/djvu2pdf-flake#djvu2pdf in.djvu out.pdf
```
or just 
```
nix run github:letac/djvu2pdf-flake# in.djvu out.pdf
```

# Tried on

- NixOS 24.05, x86_64
- macOS 12.7.6, x86_64
 
