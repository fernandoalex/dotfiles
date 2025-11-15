# Pre Nix stuff
``` bash
# Install nix
sh <(curl -L https://nixos.org/nix/install)

# add nix-darwin channel
nix-channel --add https://github.com/LnL7/nix-darwin/archive/master.tar.gz \
darwin
nix-channel --update
```
