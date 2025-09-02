# Djvu2pdf-flake
([letac/djvu2pdf](https://github.com/letac/djvu2pdf) is fork of [vindvaki/djvu2pdf](https://github.com/vindvaki/djvu2pdf) one, not the `nixpkgs` one)

Using [nix package manager](https://nixos.org/) to enable reproducible builds.

It has hOCR (for keeping the text searchable).


# Usage
To enable hOCR, download the code and
```
cd djvu2pdf-flake
nix develop
djvu2pdf yours.djvu new.pdf
exit
```

It is possible to run `nix run github:letac/djvu2pdf-flake#djvu2pdf in.djvu out.pdf`, but the resulting PDF will not have searchable text (hOCR support is missing).

# Tried on

- NixOS 24.05, x86_64
- macOS 12.7.6, x86_64
 
