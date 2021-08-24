# Dettorer's NixOS configuration

This repository contains the whole configuration for my NixOS devices. My
/home dotfiles are also described in this repository and are handled by
[home-manager](https://github.com/nix-community/home-manager).

This configuration is heavily based on [delroth's
one](https://github.com/delroth/infra.delroth.net) and makes the same tradeoffs:

- machines are meant to be single-user (only one real user other than root)
- secrets end up in the store (which means they're readable by any user)

## Structure

This repository is meant to be used by [morph](https://github.com/DBCDK/morph)
in order to build the configuration on the current machine and deploy it on any
other. The entry point is then deployment/infra.nix, and building/deployment is
done via commands like `morph deploy deployment/infra.nix switch` (see morph's
options for more details).

- `machines/*` folders contain the entry point and hardware configuration of
  each machine (the equivalent of `/etc/nixos/configuration.nix` for that
  machine).
- `roles/` contains modules that define a specific thing that I want a machine
  to be doing. Each machine that wishes the functionnalities described in a role
  enables it in its entrypoint.
- `common/` contains definitions that I want on all machines.
- `home-config/` is the home-manager configuration for my "dettorer" user (it's
  imported by `common/users.nix`.
- `my-packages/` contains the very few custom packages I want which are not
  already in nixpkgs.
- `secrets/` contains secret files encrypt with
  [git-crypt](https://github.com/AGWA/git-crypt).
