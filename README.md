# config

basic config that I use for my machines, this is a mess.

Right now most things are setup with ansible, but I am in the process of migrating things to use nix.

- https://github.com/LnL7/nix-darwin


# steps
1 - install nix
```
sh <(curl -L https://nixos.org/nix/install)
```

2 - add nix-darwin channel
```
nix-channel --add https://github.com/LnL7/nix-darwin/archive/master.tar.gz \
darwin

nix-channel --update
```
