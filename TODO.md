# TODO

## Install and configure

- fix polybar modules (see todos in home-config/polybar.nix)
- epita's ldap authentification? (make it available through a simple command, do
  not authenticate by default)
- vscode? (with the *real* neovim plugin)
- add swap to enable hybrid sleep?

## Long-term

- find a way to automatically commit the generated dotfiles for non-NixOS users
  - idea: have nix generate placeholders for unavailable secrets and create a
    github action that builds all home-manager config files (and maybe others?)
    and commits them to another repository. It should be secure since github
    action cannot decrypt `git-crypt` secrets

## Maybe

- manage secrets so that they aren't readable by everyone in store (maybe try
  sops-nix?)
- move some common stuff to a "core" role
