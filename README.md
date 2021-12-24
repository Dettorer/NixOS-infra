# Dettorer's NixOS configuration

This repository contains the whole configuration for my NixOS devices. My
`/home` dotfiles are also described in this repository and are handled by
[home-manager](https://github.com/nix-community/home-manager).

This configuration is heavily based on [delroth's
one](https://github.com/delroth/infra.delroth.net) and makes the same tradeoffs:

- machines are meant to be single-user (only one real user other than root)
- secrets end up in the store (which means they're readable by any user)

## Structure

This repository is a flake which outputs are the nixos configuration of my
machines. The entry point is the `flake.nix` file, and building/deployment
is done via commands like:

```shell-session
$ nix flake update
$ nixos-rebuild --flake ".#rivamar" \
                --target-host rivamar \
                --build-host localhost \
                switch
```

See [the officiel
documentation](https://nixos.wiki/wiki/Flakes#Using_nix_flakes_with_NixOS) for
more information.

- `machines/*` folders contain the entry point and hardware configuration of
  each machine (the equivalent of `/etc/nixos/configuration.nix` for that
  machine).
- `roles/` contains modules that define a specific thing that I want a machine
  to be doing. Each machine that wishes the functionnalities described in a role
  enables it in its entrypoint.
- `common/` contains definitions that I want on all machines.
- `home-config/` is the home-manager configuration for my "dettorer" user (it's
  imported by `common/users.nix`).
- `my-packages/` contains the few custom packages I want which are not already
  in nixpkgs. The whole folder is used as an
  [overlay](https://nixos.wiki/wiki/Overlays) on nixpkgs.
- `secrets/` contains secret files encrypt with
  [git-crypt](https://github.com/AGWA/git-crypt).
