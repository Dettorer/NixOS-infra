let
  canaryHash = builtins.hashFile "sha256" ./secrets/canary;
  expectedHash = "5c7fc75af6c96aa2c3cdecb561a42e3dbaafedf40948375d05dd4a715debd564";
in
  if canaryHash != expectedHash then abort "Files in the secrets/ folder still seem encrypted, did you run `git-crypt unlock`?"
  else {
    syncthing = import ./secrets/syncthing.nix;
    roles = import ./secrets/roles;
  }
